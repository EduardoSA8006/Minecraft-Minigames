import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minigames_minecraft/data/models/item_model.dart';

class ItemRepository {
  final FirebaseFirestore _firestore;

  ItemRepository(this._firestore);

  Future<List<Item>> getItems() async {
    final snapshot = await _firestore.collection('items').get();
    return snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList();
  }

  Future<void> addItem(Item item) async {
    await _firestore.collection('items').doc(item.id).set(item.toJson());
  }

  Future<void> updateItem(Item item) async {
    await _firestore.collection('items').doc(item.id).update(item.toJson());
  }

  Stream<List<Item>> watchItems() {
    return _firestore.collection('items').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList();
    });
  }
}



/*final itemsProvider = StreamProvider<List<Item>>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return repository.watchItems();
});*/