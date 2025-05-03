import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minigames_minecraft/data/models/item_model.dart';
import 'package:minigames_minecraft/data/repositories/item_repository.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemSuccess extends ItemState {
  final Item? item; // Adicionado para edição
  ItemSuccess([this.item]);
}

class ItemError extends ItemState {
  final String message;
  ItemError(this.message);
}

class ItemCubit extends Cubit<ItemState> {
  final ItemRepository _repository;

  ItemCubit(this._repository) : super(ItemInitial());

  // Método para adicionar OU editar item
  Future<void> saveItem(Item item, {bool isEditing = false}) async {
    // Validações
    if (item.id.isEmpty || !item.id.startsWith('minecraft:')) {
      emit(ItemError('ID inválido. Deve começar com "minecraft:"'));
      return;
    }

    if (item.nome['pt']?.isEmpty ?? true) {
      emit(ItemError('Nome em português é obrigatório'));
      return;
    }

    emit(ItemLoading());
    try {
      if (isEditing) {
        await _repository.updateItem(item);
      } else {
        await _repository.addItem(item);
      }
      emit(ItemSuccess(isEditing ? item : null));
    } catch (e) {
      emit(ItemError('Erro ao ${isEditing ? 'editar' : 'salvar'}: $e'));
    }
  }

  // Método para carregar item para edição
  Future<void> loadItemForEditing(String itemId) async {
    emit(ItemLoading());
    try {
      final items = await _repository.getItems();
      final item = items.firstWhere((i) => i.id == itemId);
      emit(ItemSuccess(item));
    } catch (e) {
      emit(ItemError('Item não encontrado'));
    }
  }
}
