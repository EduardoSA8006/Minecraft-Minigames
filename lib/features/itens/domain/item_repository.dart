import 'package:minigames_minecraft/features/itens/domain/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItems();
}
