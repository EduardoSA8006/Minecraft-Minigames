import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/app/providers/search_filter_provider.dart';

Future<void> showFilterDialog(BuildContext context, WidgetRef ref) async {
  final currentFilters = ref.watch(searchFilterProvider);

  String? selectedRarity = currentFilters.rarityFilter;
  String? selectedCategory = currentFilters.categoryFilter;
  String? selectedStackSize = currentFilters.stackSizeFilter;
  String? selectedRenewable = currentFilters.renewableFilter;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text('Filtrar itens'),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxHeight: 500),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(
                  label: "Agrupamento",
                  value: selectedStackSize,
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Todos')),
                    DropdownMenuItem(value: '64', child: Text('64 por slot')),
                    DropdownMenuItem(value: '16', child: Text('16 por slot')),
                    DropdownMenuItem(value: '1', child: Text('1 por slot')),
                  ],
                  onChanged: (value) => selectedStackSize = value,
                ),
                _buildDropdown(
                  label: "Raridade",
                  value: selectedRarity,
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Todos')),
                    DropdownMenuItem(value: 'comum', child: Text('Comum')),
                    DropdownMenuItem(value: 'raro', child: Text('Raro')),
                    DropdownMenuItem(value: 'épico', child: Text('Épico')),
                    DropdownMenuItem(
                        value: 'lendário', child: Text('Lendário')),
                  ],
                  onChanged: (value) => selectedRarity = value,
                ),
                _buildDropdown(
                  label: "Categoria",
                  value: selectedCategory,
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Todos')),
                    DropdownMenuItem(
                        value: 'ferramentas', child: Text('Ferramentas')),
                    DropdownMenuItem(value: 'armas', child: Text('Armas')),
                    DropdownMenuItem(value: 'blocos', child: Text('Blocos')),
                    DropdownMenuItem(value: 'comida', child: Text('Comida')),
                    DropdownMenuItem(
                        value: 'encantamentos', child: Text('Encantamentos')),
                  ],
                  onChanged: (value) => selectedCategory = value,
                ),
                _buildDropdown(
                  label: "Renovável",
                  value: selectedRenewable,
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Todos')),
                    DropdownMenuItem(value: 'Sim', child: Text('Sim')),
                    DropdownMenuItem(value: 'Não', child: Text('Não')),
                  ],
                  onChanged: (value) => selectedRenewable = value,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(searchFilterProvider.notifier)
                              .clearFilters();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 75, 62),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Limpar filtros',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(searchFilterProvider.notifier).setFilters(
                                rarity: selectedRarity,
                                category: selectedCategory,
                                stackSize: selectedStackSize,
                                renewable: selectedRenewable,
                              );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 49, 162, 255),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Aplicar',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildDropdown({
  required String label,
  required String? value,
  required List<DropdownMenuItem<String?>> items,
  required void Function(String?) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String?>(
          isExpanded: true,
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
