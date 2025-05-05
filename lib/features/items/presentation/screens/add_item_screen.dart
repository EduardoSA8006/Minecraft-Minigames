import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/app/providers/app_providers.dart';
import 'package:minigames_minecraft/features/items/models/item_model.dart';
import 'package:minigames_minecraft/features/items/presentation/cubit/item_cubit.dart';
import 'package:minigames_minecraft/features/items/presentation/widgets/multi_selects.dart';

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
  final _imagemController = TextEditingController();
  final _durabilidadeController = TextEditingController();

  String? _categoriaController;
  String? _versaoAdicaoController;
  String? _raridadeController;
  bool _renovavelController = true;
  List<String>? _ondeEncontradoController;
  int? _stackSizeController = 64;

  @override
  void dispose() {
    _nomeController.dispose();
    _idController.dispose();
    _descricaoController.dispose();
    _imagemController.dispose();
    _durabilidadeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> newItem = {
        "nome": _nomeController.text,
        "id": _idController.text,
        "descricao": _descricaoController.text,
        "imagem": _imagemController.text,
        "durabilidade": _durabilidadeController.text,
        "versao_adicao": _versaoAdicaoController,
        "categoria": _categoriaController,
        "raridade": _raridadeController,
        "renovavel": _renovavelController,
        "onde_encontrado": _ondeEncontradoController,
        "stack_size": _stackSizeController,
        "crafting": {},
      };

      final String? _erro =
          await ref.read(addItemViewModelProvider.notifier).submit(newItem);
      if (_erro != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_erro)),
        );
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item salvo com sucesso!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(addItemViewModelProvider).isLoading;

    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Item'),
          backgroundColor: const Color.fromARGB(255, 48, 136, 51),
        ),
        body: BlocListener<ItemCubit, ItemState>(
          listener: (context, state) {
            if (state is ItemError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro: ${state.message}')),
              );
            } else if (state is ItemSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item salvo com sucesso!')));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(_nomeController, 'Nome'),
                    _buildTextField(_idController, 'ID'),
                    _buildTextField(_descricaoController, 'Descrição'),
                    _buildDropdown(
                        label: "Versão de adição",
                        value: _versaoAdicaoController,
                        items: ["1", "2", "3"],
                        onChanged: (val) =>
                            setState(() => _versaoAdicaoController = val)),
                    _buildTextField(_imagemController, 'URL da Imagem'),
                    _buildDropdown<String>(
                      label: 'Categoria',
                      value: _categoriaController,
                      items: [
                        'Ferramentas e Armas',
                        'Armaduras e Vestuário',
                        'Comidas e Poções',
                        'Recursos e Materiais',
                        'Itens Mágicos e Raros',
                        'Utilitários Diversos'
                      ],
                      onChanged: (val) =>
                          setState(() => _categoriaController = val),
                    ),
                    _buildDropdown<String>(
                      label: 'Raridade',
                      value: _raridadeController,
                      items: ['comum', 'incomum', 'raro', 'lendário'],
                      onChanged: (val) =>
                          setState(() => _raridadeController = val),
                    ),
                    const Text("Onde é encontrado",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 6),
                    MultiSelectChip(
                      options: const [
                        'Crafting',
                        'Baus',
                        'Mob Drops',
                        'Mineração',
                        'Comércio',
                      ],
                      selectedOptions: _ondeEncontradoController ?? [],
                      onSelectionChanged: (val) {
                        setState(() {
                          _ondeEncontradoController = val;
                        });
                      },
                    ),
                    _buildDropdown<int>(
                      label: 'Stack Size',
                      value: _stackSizeController,
                      items: [1, 16, 64],
                      onChanged: (val) =>
                          setState(() => _stackSizeController = val!),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Renovável'),
                      value: _renovavelController,
                      onChanged: (val) =>
                          setState(() => _renovavelController = val),
                    ),
                    if (_categoriaController == 'Ferramentas e Armas')
                      _buildTextField(_durabilidadeController, 'Durabilidade',
                          isNumber: true),
                    const SizedBox(height: 20),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: SizedBox(
                        height: 55,
                        key: ValueKey<bool>(isLoading),
                        child: ElevatedButton(
                            onPressed: isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 37, 89, 219),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              disabledBackgroundColor: Colors.blue,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.save,
                                        size: 23,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Salvar",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: isNumber
              ? const Icon(Icons.numbers, color: Colors.grey)
              : const Icon(Icons.text_fields, color: Colors.grey),
          labelText: label,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 1),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        items: items
            .map((e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(e.toString()),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Selecione uma opção' : null,
      ),
    );
  }
}
