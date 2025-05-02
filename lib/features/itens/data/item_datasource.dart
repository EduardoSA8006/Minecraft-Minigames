import 'package:minigames_minecraft/features/itens/data/item_model.dart';

abstract class ItemDataSource {
  Future<List<ItemModel>> fetchItems();
}
