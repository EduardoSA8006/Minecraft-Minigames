import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minigames_minecraft/features/items/models/item_model.dart';
import 'package:minigames_minecraft/features/items/repositories/item_repository.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemSuccess extends ItemState {
  final Item? item;
  ItemSuccess([this.item]);
}

class ItemListSuccess extends ItemState {
  final List<Item> items;
  ItemListSuccess(this.items);
}

class ItemError extends ItemState {
  final String message;
  ItemError(this.message);
}

class ItemCubit extends Cubit<ItemState> {
  final ItemRepository _repository;

  ItemCubit(this._repository) : super(ItemInitial());

  Future<void> addItem(Item item) async {
    emit(ItemLoading());
    if (item.id.isEmpty || !item.id.startsWith('minecraft:')) {
      emit(ItemError('ID inválido'));
      return;
    }
    try {
      await _repository.addItem(item);
      emit(ItemSuccess(item));
    } catch (e) {
      emit(ItemError('Erro ao adicionar item: $e'));
    }
  }

  Future<void> updateItem(Item item) async {
    emit(ItemLoading());
    if (item.id.isEmpty || !item.id.startsWith('minecraft:')) {
      emit(ItemError('ID inválido'));
      return;
    }
    try {
      await _repository.updateItem(item);
      emit(ItemSuccess(item));
    } catch (e) {
      emit(ItemError('Erro ao editar item: $e'));
    }
  }

  Future<void> deleteItem(Item item) async {
    final itemId = item.id;
    if (itemId.isEmpty || !itemId.startsWith('minecraft:')) {
      emit(ItemError('ID inválido'));
      return;
    }
    emit(ItemLoading());
    try {
      await _repository.deleteItem(item);
      emit(ItemSuccess(null));
    } catch (e) {
      emit(ItemError('Erro ao deletar item: $e'));
    }
  }

  Future<void> getItem(Item item) async {
    if (item.id.isEmpty || !item.id.startsWith('minecraft:')) {
      emit(ItemError('ID inválido'));
      return;
    }
    emit(ItemLoading());
    if (item.id.isEmpty || !item.id.startsWith('minecraft:')) {
      emit(ItemError('ID inválido'));
      return;
    }
    try {
      final itemResult = await _repository.getItem(item);
      emit(ItemSuccess(itemResult));
    } catch (e) {
      emit(ItemError('Erro ao carregar iten: $e'));
    }
  }

  Future<void> getAllItems() async {
    emit(ItemLoading());
    try {
      final items = await _repository.getAllItems();
      if (items == null || items.isEmpty) {
        emit(ItemError('Nenhum item encontrado'));
        return;
      }
      emit(ItemListSuccess(items));
    } catch (e) {
      emit(ItemError('Erro ao carregar itens: $e'));
    }
  }
}
