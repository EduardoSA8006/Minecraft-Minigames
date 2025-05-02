import 'package:minigames_minecraft/features/itens/domain/item.dart';

import '../item_repository.dart';

class GetAllItemsUseCase {
  final ItemRepository repository;

  GetAllItemsUseCase(this.repository);

  Future<List<Item>> call() {
    return repository.getAllItems();
  }
}
