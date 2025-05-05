import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minigames_minecraft/features/items/models/item_model.dart';

class ItemRepository {
  final FirebaseFirestore _firestore;

  ItemRepository(this._firestore);

  Future<Item?> getItem(Item item) async {
    final snapshot = await _firestore.collection('items').doc(item.id).get();
    if (snapshot.exists) {
      return Item.fromJson(json: snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<List<Item>?> getAllItems() async {
    final snapshot = await _firestore.collection('items').get();
    if (snapshot.docs.isEmpty) {
      return null;
    } else {
      return snapshot.docs
          .map((doc) => Item.fromJson(json: doc.data()))
          .toList();
    }
  }

  Future<bool> itemExists(Item item) async {
    final snapshot = await _firestore.collection('items').doc(item.id).get();
    return snapshot.exists;
  }

  Future<void> addItem(Item item) async {
    final existingItem = await itemExists(item);
    if (existingItem == false) {
      await _firestore.collection('items').doc(item.id).set(item.toJson());
    } else {
      throw Exception('Item with ID ${item.id} already exists.');
    }
  }

  Future<void> updateItem(Item item) async {
    final existingItem = await itemExists(item);
    if (existingItem) {
      await _firestore.collection('items').doc(item.id).update(item.toJson());
    } else {
      throw Exception('Item with ID ${item.id} does not exist.');
    }
  }

  Future<void> deleteItem(Item item) async {
    final existingItem = await itemExists(item);
    if (existingItem) {
      await _firestore.collection('items').doc(item.id).delete();
    } else {
      throw Exception('Item with ID ${item.id} does not exist.');
    }
  }

  Stream<List<Item>> watchItems() {
    return _firestore.collection('items').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Item.fromJson(json: doc.data()))
          .toList();
    });
  }
}
