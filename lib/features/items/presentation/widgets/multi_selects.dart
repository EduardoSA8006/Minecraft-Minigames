import 'package:flutter/material.dart';

class MultiSelectChip extends StatelessWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final void Function(List<String>) onSelectionChanged;

  const MultiSelectChip({
    required this.options,
    required this.selectedOptions,
    required this.onSelectionChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: options.map((option) {
        final selected = selectedOptions.contains(option);
        return FilterChip(
          label: Text(option),
          selected: selected,
          onSelected: (bool isSelected) {
            final updated = List<String>.from(selectedOptions);
            isSelected ? updated.add(option) : updated.remove(option);
            onSelectionChanged(updated);
          },
        );
      }).toList(),
    );
  }
}
