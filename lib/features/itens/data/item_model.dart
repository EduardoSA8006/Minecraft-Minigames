import '../../itens/domain/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.nomes,
    required super.tipo,
    required super.imageUrl,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      nomes: Map<String, String>.from(map['nomes']),
      tipo: map['tipo'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomes': nomes,
      'tipo': tipo,
      'imageUrl': imageUrl,
    };
  }
}
