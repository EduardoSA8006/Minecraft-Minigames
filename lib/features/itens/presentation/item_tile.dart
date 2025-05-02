import 'package:flutter/material.dart';
import 'package:minigames_minecraft/features/itens/domain/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.nomes?[0] ?? 'Sem nome'),
      subtitle: Text(item.tipo?[0] ?? 'Sem tipo'),
    );
  }
}
