import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'item_datasource_firestore.dart';
import 'item_datasource.dart';
import 'item_repository_impl.dart';
import '../domain/item_repository.dart';

// Firestore
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// DataSource
final itemDataSourceProvider = Provider<ItemDataSource>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ItemDataSourceFirestore(firestore: firestore);
});

// Repository
final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final dataSource = ref.watch(itemDataSourceProvider);
  return ItemRepositoryImpl(dataSource);
});
