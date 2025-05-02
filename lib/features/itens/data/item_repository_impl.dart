import 'package:minigames_minecraft/features/itens/data/item_datasource.dart';

import '../../itens/domain/item.dart';
import '../../itens/domain/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource dataSource;

  ItemRepositoryImpl(this.dataSource);

  @override
  Future<List<Item>> getAllItems() async {
    return await dataSource.fetchItems();
  }
}
