import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minigames_minecraft/features/itens/data/item_model.dart';
import 'item_datasource.dart';

class ItemDataSourceFirestore implements ItemDataSource {
  final FirebaseFirestore firestore;

  ItemDataSourceFirestore({required this.firestore});

  @override
  Future<List<ItemModel>> fetchItems() async {
    final snapshot = await firestore.collection('itens').get();
    return snapshot.docs.map((doc) {
      return ItemModel.fromMap(doc.data());
    }).toList();
  }
}
