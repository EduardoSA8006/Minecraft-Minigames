import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/app/providers/app_providers.dart';
import 'package:minigames_minecraft/app/providers/search_filter_provider.dart';
import 'package:minigames_minecraft/features/items/models/item_model.dart';

final filteredItemsProvider = Provider<List<Item>>((ref) {
  final items = ref.watch(itemsProvider).value ?? [];
  final filterState = ref.watch(searchFilterProvider);

  return items.where((item) {
    // Filtro de busca por texto
    final matchesSearch = item.nome['pt']?.toLowerCase().contains(
              filterState.searchQuery.toLowerCase(),
            ) ??
        false;

    // Filtro de raridade
    final matchesRarity = filterState.rarityFilter == null ||
        item.raridade.toLowerCase() == filterState.rarityFilter?.toLowerCase();

    // Filtro de categoria
    final matchesCategory = filterState.categoryFilter == null ||
        item.categoria.toLowerCase() ==
            filterState.categoryFilter?.toLowerCase();

    // Filtro de stack size
    final matchesStackSize = filterState.stackSizeFilter == null ||
        item.stackSize.toString() == filterState.stackSizeFilter;

    // Filtro de renovável
    final matchesRenewable = filterState.renewableFilter == null ||
        (filterState.renewableFilter == 'Sim' && item.renovavel) ||
        (filterState.renewableFilter == 'Não' && !item.renovavel);

    return matchesSearch &&
        matchesRarity &&
        matchesCategory &&
        matchesStackSize &&
        matchesRenewable;
  }).toList();
});
