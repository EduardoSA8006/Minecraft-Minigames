import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/app/providers/app_providers.dart';
import 'package:minigames_minecraft/data/models/item_model.dart';
import 'package:minigames_minecraft/features/items/presentation/cubit/item_cubit.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _idController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _versaoAdicaoController = TextEditingController();
  final _imagemController = TextEditingController();
  final _durabilidadeController = TextEditingController();

  String? _categoriaController;
  String? _raridadeController;
  bool? _renovavelController;
  List<String>? _ondeEncontradoController;
  Map<String, String>? _craftingController = {};
  int? _stackSizeController;

  @override
  void dispose() {
    _nomeController.dispose();
    _idController.dispose();
    _descricaoController.dispose();
    _versaoAdicaoController.dispose();
    _imagemController.dispose();
    _durabilidadeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final newItem = Item(
        nome: {'pt': _nomeController.text, 'en': _nomeController.text},
        id: _idController.text,
        stackSize: 64,
        categoria: "ferramenta",
        versaoAdicao: '1.20',
        ondeEncontrado: ['crafting'],
        imagem: '',
        descricao: 'Descrição temporária',
        raridade: 'comum',
        durabilidade: null,
        renovavel: true,
        crafting: {},
      );

      final cubit = ref.read(itemCubitProvider);
      await cubit.saveItem(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemCubitProvider).state;

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Item')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(labelText: 'Nome (PT)'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Obrigatório' : null,
                  ),
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                        labelText: 'ID (ex: minecraft:diamond_sword)'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Obrigatório' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Categoria'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Obrigatório' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is ItemLoading ? null : _submit,
                    child: const Text('Salvar Item'),
                  ),
                ],
              ),
            ),
          ),

          // Mostra loading durante a operação
          if (state is ItemLoading)
            const Center(child: CircularProgressIndicator()),

          // Trata erros
          if (state is ItemError)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.redAccent,
                child: Text(
                  (state as ItemError).message,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
