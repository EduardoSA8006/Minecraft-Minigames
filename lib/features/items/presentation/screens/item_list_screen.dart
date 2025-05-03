import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minigames_minecraft/app/providers/app_providers.dart';
import 'package:minigames_minecraft/data/models/item_model.dart';
import 'package:minigames_minecraft/features/items/presentation/widgets/itens_card.dart';

class ItemListScreen extends ConsumerWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 136, 51),
        title: const Text('Minecraft Itens'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: ItemSearchDelegate(ref: ref, items: []),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: itemsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Erro: $err')),
          data: (items) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => ItemCard(item: items[index]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-item'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemSearchDelegate extends SearchDelegate {
  final WidgetRef ref;
  final List<String> items;

  ItemSearchDelegate({required this.ref, required this.items});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results.map((item) => ListTile(title: Text(item))).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = items
        .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions
          .map((item) => ListTile(
                title: Text(item),
                onTap: () {
                  query = item;
                  showResults(context);
                },
              ))
          .toList(),
    );
  }
}

void _showFilterDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Filtrar itens'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Adicione seus filtros aqui
        ],
      ),
    ),
  );
}
