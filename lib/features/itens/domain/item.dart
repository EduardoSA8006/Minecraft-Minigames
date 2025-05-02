class Item {
  final String id;
  final Map<String, String> nomes; // pt, en, etc.
  final String tipo; // Ex: material, bloco, mob...
  final String imageUrl;

  Item({
    required this.id,
    required this.nomes,
    required this.tipo,
    required this.imageUrl,
  });
}
