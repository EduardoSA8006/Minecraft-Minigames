import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minigames_minecraft/features/items/models/item_model.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/edit-item/${item.id}'),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12, top: 9, bottom: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone com imagem de fundo estilo Minecraft
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: _getItemColor(item.categoria),
                    borderRadius: BorderRadius.circular(8),
                    image: item.imagem.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(item.imagem),
                            fit: BoxFit.contain,
                          )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: item.imagem.isEmpty
                      ? const Icon(Icons.casino, size: 40)
                      : null),
              const SizedBox(height: 8),
              Text(
                item.nome['pt'] ?? 'Sem nome',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 11),
              Row(
                children: [
                  const Icon(Icons.layers, size: 20, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${item.stackSize}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      item.raridade.toUpperCase(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: _getRarityColor(item.raridade),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Cor baseada na categoria do item
  Color _getItemColor(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'armas':
        return Colors.red[100]!;
      case 'ferramentas':
        return Colors.blue[100]!;
      case 'comida':
        return Colors.green[100]!;
      case 'blocos':
        return Colors.brown[100]!;
      default:
        return Colors.grey[200]!;
    }
  }

  // Cor baseada na raridade
  Color _getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'raro':
        return Colors.blue;
      case 'épico':
        return Colors.purple;
      case 'lendário':
        return Colors.orange;
      case 'comum':
      default:
        return Colors.grey;
    }
  }
}
