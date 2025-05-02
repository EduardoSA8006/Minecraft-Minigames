import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/features/itens/domain/item.dart';
import 'package:minigames_minecraft/features/itens/domain/item_usecases_provider.dart';

final itemListControllerProvider =
    AsyncNotifierProvider<ItemListController, List<Item>>(
        ItemListController.new);

class ItemListController extends AsyncNotifier<List<Item>> {
  @override
  Future<List<Item>> build() async {
    final usecase = ref.read(getAllItemsUseCaseProvider);
    return await usecase();
  }
}
