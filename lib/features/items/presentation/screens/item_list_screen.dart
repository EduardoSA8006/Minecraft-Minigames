import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minigames_minecraft/app/providers/app_providers.dart';
import 'package:minigames_minecraft/app/providers/filtered_items_provider.dart';
import 'package:minigames_minecraft/app/providers/search_filter_provider.dart';
import 'package:minigames_minecraft/features/items/models/item_model.dart';
import 'package:minigames_minecraft/features/items/presentation/widgets/itens_card.dart';
import 'package:minigames_minecraft/features/items/presentation/widgets/show_filter_dialog.dart';

// Alterado para ConsumerStatefulWidget
class ItemListScreen extends ConsumerStatefulWidget {
  const ItemListScreen({super.key});

  @override
  ConsumerState<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends ConsumerState<ItemListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _searchBarController;
  late Animation<double> _searchBarAnimation;
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchBar = false;

  @override
  void initState() {
    super.initState();
    _searchBarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchBarAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _searchBarController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (_showSearchBar) {
        _searchBarController.forward();
      } else {
        _searchBarController.reverse();
        _searchController.clear();
        ref.read(searchFilterProvider.notifier).setSearchQuery('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsProvider);
    final filteredItems = ref.watch(filteredItemsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 136, 51),
        title: const Text('Minecraft Itens'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => showFilterDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearchBar,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            SizeTransition(
              sizeFactor: _searchBarAnimation,
              axisAlignment: -1.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar itens...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        ref
                            .read(searchFilterProvider.notifier)
                            .setSearchQuery('');
                      },
                    ),
                  ),
                  onChanged: (value) {
                    ref
                        .read(searchFilterProvider.notifier)
                        .setSearchQuery(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 8, top: 12),
                child: itemsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text('Erro: $err')),
                  data: (_) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) =>
                        ItemCard(item: filteredItems[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-item'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
