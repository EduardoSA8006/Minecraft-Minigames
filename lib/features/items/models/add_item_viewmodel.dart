import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/features/items/models/item_model.dart';
import 'package:minigames_minecraft/features/items/presentation/cubit/item_cubit.dart';

class AddItemState {
  final bool isLoading;
  final String nomePt;
  final String id;
  final String descricao;
  final String imagem;
  final String durabilidade;
  final String versaoAdicao;
  final String raridade;
  final bool renovavel;
  final List<String> ondeEncontrado;
  final int stackSize;
  final Map<String, String> crafting;
  final String categoria;

  const AddItemState({
    this.isLoading = false,
    this.nomePt = '',
    this.id = '',
    this.descricao = '',
    this.imagem = '',
    this.durabilidade = '',
    this.versaoAdicao = '',
    this.raridade = '',
    this.renovavel = false,
    this.ondeEncontrado = const [],
    this.stackSize = 64,
    this.crafting = const {},
    this.categoria = '',
  });

  AddItemState copyWith({
    bool? isLoading,
    String? nomePt,
    String? id,
    String? descricao,
    String? imagem,
    String? durabilidade,
    String? versaoAdicao,
    String? raridade,
    bool? renovavel,
    List<String>? ondeEncontrado,
    int? stackSize,
    Map<String, String>? crafting,
    String? categoria,
  }) {
    return AddItemState(
      isLoading: isLoading ?? this.isLoading,
      nomePt: nomePt ?? this.nomePt,
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
      durabilidade: durabilidade ?? this.durabilidade,
      versaoAdicao: versaoAdicao ?? this.versaoAdicao,
      raridade: raridade ?? this.raridade,
      renovavel: renovavel ?? this.renovavel,
      ondeEncontrado: ondeEncontrado ?? this.ondeEncontrado,
      stackSize: stackSize ?? this.stackSize,
      crafting: crafting ?? this.crafting,
      categoria: categoria ?? this.categoria,
    );
  }
}

class AddItemViewModel extends StateNotifier<AddItemState> {
  final ItemCubit itemCubit;

  AddItemViewModel({required this.itemCubit}) : super(const AddItemState());

  void _updateState(AddItemState Function(AddItemState) update) {
    state = update(state);
  }

  void setNomePt(String value) =>
      _updateState((s) => s.copyWith(nomePt: value));
  void setIsLoading(bool value) =>
      _updateState((s) => s.copyWith(isLoading: value));
  void setId(String value) => _updateState((s) => s.copyWith(id: value));
  void setCategoria(String value) =>
      _updateState((s) => s.copyWith(categoria: value));
  void setDescricao(String value) =>
      _updateState((s) => s.copyWith(descricao: value));
  void setImagem(String value) =>
      _updateState((s) => s.copyWith(imagem: value));
  void setDurabilidade(String value) =>
      _updateState((s) => s.copyWith(durabilidade: value));
  void setVersaoAdicao(String value) =>
      _updateState((s) => s.copyWith(versaoAdicao: value));
  void setRaridade(String value) =>
      _updateState((s) => s.copyWith(raridade: value));
  void setRenovavel(bool value) =>
      _updateState((s) => s.copyWith(renovavel: value));
  void setOndeEncontrado(List<String> value) =>
      _updateState((s) => s.copyWith(ondeEncontrado: value));
  void setStackSize(int value) =>
      _updateState((s) => s.copyWith(stackSize: value));
  void setCrafting(Map<String, String> value) =>
      _updateState((s) => s.copyWith(crafting: value));

  String? _validate() {
    if (state.nomePt.isEmpty) return 'Nome é obrigatório';
    if (state.id.isEmpty) return 'ID é obrigatório';
    if (!state.id.startsWith('minecraft:'))
      return 'ID deve começar com "minecraft:"';
    if (state.categoria.isEmpty) return 'Categoria é obrigatória';
    if (state.descricao.isEmpty) return 'Descrição é obrigatória';
    if (state.imagem.isEmpty) return 'Imagem é obrigatória';
    if (state.durabilidade.isNotEmpty) {
      final durabilidade = int.tryParse(state.durabilidade);
      if (durabilidade == null || durabilidade < 0)
        return 'Durabilidade deve ser um número positivo';
    }
    if (state.stackSize < 1 || state.stackSize > 64)
      return 'Tamanho da pilha deve ser entre 1 e 64';
    if (state.raridade.isEmpty) return 'Raridade é obrigatória';
    if (state.ondeEncontrado.isEmpty) return 'Onde encontrado é obrigatório';
    if (state.crafting.isEmpty) return 'Crafting é obrigatório';
    if (state.versaoAdicao.isEmpty) return 'Versão de adição é obrigatória';
    return null;
  }

  Future<String?> submit(Map<String, dynamic> item) async {
    _updateState((s) => s.copyWith(isLoading: true));

    _updateState((s) => s.copyWith(
          nomePt: item['nome']['pt'],
          id: item['id'],
          categoria: item['categoria'],
          descricao: item['descricao'],
          imagem: item['imagem'],
          durabilidade: item['durabilidade'],
          versaoAdicao: item['versao_adicao'],
          raridade: item['raridade'],
          renovavel: item['renovavel'],
          ondeEncontrado: List<String>.from(item['onde_encontrado']),
          stackSize: item['stack_size'],
          crafting: Map<String, String>.from(item['crafting']),
        ));

    final error = _validate();
    if (error != null) {
      _updateState((s) => s.copyWith(isLoading: false));
      return error;
    }

    try {
      await itemCubit.addItem(Item.fromJson(json: {
        'nome': {'pt': state.nomePt},
        'id': state.id,
        'stack_size': state.stackSize,
        'categoria': state.categoria,
        'versao_adicao': state.versaoAdicao,
        'onde_encontrado': state.ondeEncontrado,
        'imagem': state.imagem,
        'descricao': state.descricao,
        'raridade': state.raridade,
        'durabilidade': int.tryParse(state.durabilidade),
        'renovavel': state.renovavel,
        'crafting': state.crafting,
      }));
      return null;
    } catch (e) {
      return 'Erro ao adicionar item: $e';
    } finally {
      _updateState((s) => s.copyWith(isLoading: false));
    }
  }
}
