import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minigames_minecraft/app/providers/app_providers.dart';
import 'package:minigames_minecraft/features/items/presentation/cubit/item_cubit.dart';
import 'package:minigames_minecraft/features/items/presentation/screens/add_item_screen.dart';
import 'package:minigames_minecraft/features/items/presentation/screens/edit_item_screen.dart';
import 'package:minigames_minecraft/features/items/presentation/screens/item_list_screen.dart';
import 'package:minigames_minecraft/features/items/repositories/item_repository.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ItemListScreen(),
    ),
    GoRoute(
      path: '/edit-item/:itemId',
      builder: (context, state) {
        final itemId = state.pathParameters['itemId']!;
        return EditItemScreen(itemId: itemId);
      },
    ),
    GoRoute(
      path: '/add-item',
      builder: (context, state) => BlocProvider(
        create: (_) => ItemCubit(
          ItemRepository(FirebaseFirestore.instance),
        ),
        child: const AddItemScreen(),
      ),
    )
  ],
);
