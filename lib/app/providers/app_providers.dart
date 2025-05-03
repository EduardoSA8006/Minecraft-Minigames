import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minigames_minecraft/data/models/item_model.dart';
import 'package:minigames_minecraft/data/repositories/item_repository.dart';
import 'package:minigames_minecraft/features/items/presentation/cubit/item_cubit.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository(ref.read(firestoreProvider));
});

final itemCubitProvider = Provider<ItemCubit>((ref) {
  return ItemCubit(ref.read(itemRepositoryProvider));
});


final itemsProvider = StreamProvider<List<Item>>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return repository
      .watchItems();
});
