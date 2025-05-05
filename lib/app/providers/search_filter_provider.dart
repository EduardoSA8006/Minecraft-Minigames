import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFilterProvider =
    StateNotifierProvider<SearchFilterNotifier, SearchFilterState>((ref) {
  return SearchFilterNotifier();
});

class SearchFilterNotifier extends StateNotifier<SearchFilterState> {
  SearchFilterNotifier() : super(SearchFilterState());

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFilters({
    String? rarity,
    String? category,
    String? stackSize,
    String? renewable,
  }) {
    state = state.copyWith(
      rarityFilter: rarity,
      categoryFilter: category,
      stackSizeFilter: stackSize,
      renewableFilter: renewable,
    );
  }

  void clearFilters() {
    state = SearchFilterState();
  }
}

@immutable
class SearchFilterState {
  final String searchQuery;
  final String? rarityFilter;
  final String? categoryFilter;
  final String? stackSizeFilter;
  final String? renewableFilter;

  const SearchFilterState({
    this.searchQuery = '',
    this.rarityFilter,
    this.categoryFilter,
    this.stackSizeFilter,
    this.renewableFilter,
  });

  SearchFilterState copyWith({
    String? searchQuery,
    String? rarityFilter,
    String? categoryFilter,
    String? stackSizeFilter,
    String? renewableFilter,
  }) {
    return SearchFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      rarityFilter: rarityFilter ?? this.rarityFilter,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      stackSizeFilter: stackSizeFilter ?? this.stackSizeFilter,
      renewableFilter: renewableFilter ?? this.renewableFilter,
    );
  }
}
