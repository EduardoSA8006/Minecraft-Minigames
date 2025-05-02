import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/item.dart';
import 'item_tile.dart';
import 'item_list_controller.dart';

class ItemListScreen extends ConsumerWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(itemListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Itens')),
      body: asyncItems.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) => ItemTile(item: items[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
