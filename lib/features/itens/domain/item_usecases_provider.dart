import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/features/itens/data/item_providers.dart';
import 'usecases/get_all_items_usecase.dart';

final getAllItemsUseCaseProvider = Provider<GetAllItemsUseCase>((ref) {
  final repo = ref.watch(itemRepositoryProvider);
  return GetAllItemsUseCase(repo);
});
