import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/app/providers/app_providers.dart';
import 'package:minigames_minecraft/features/items/presentation/cubit/item_cubit.dart';

class EditItemScreen extends ConsumerStatefulWidget {
  final String itemId;

  const EditItemScreen({super.key, required this.itemId});

  @override
  ConsumerState<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends ConsumerState<EditItemScreen> {
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
  void initState() {
    super.initState();
    _loadItem();
  }

  Future<void> _loadItem() async {
    //await ref.read(itemCubitProvider).updateItem(widget.itemId);
  }

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
    final state = ref.read(itemCubitProvider).state;

    if (state is ItemSuccess && state.item != null) {
      // final updatedItem = state.item!.copyWith(
      // nome: {'pt': _nomeController.text, 'en': _nomeController.text},
      //ategoria: "ferramentas",
      //);

      //await ref.read(itemCubitProvider).saveItem(updatedItem, isEditing: true);

      if (mounted && ref.read(itemCubitProvider).state is ItemSuccess) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemCubitProvider).state;

    // Preenche os campos quando o item é carregado
    if (state is ItemSuccess && state.item != null) {
      _nomeController.text = state.item!.nome['pt'] ?? '';
      _idController.text = state.item!.id;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Item')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(labelText: 'Nome (PT)'),
                  ),
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(labelText: 'ID'),
                    enabled: false,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Categoria'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is ItemLoading ? null : _submit,
                    child: const Text('Salvar Alterações'),
                  ),
                ],
              ),
            ),
          ),
          if (state is ItemLoading)
            const Center(child: CircularProgressIndicator()),
          if (state is ItemError)
            Positioned(
              bottom: 20,
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
