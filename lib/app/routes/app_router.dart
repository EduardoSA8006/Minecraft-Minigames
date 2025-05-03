import 'package:go_router/go_router.dart';
import 'package:minigames_minecraft/features/items/presentation/screens/add_item_screen.dart';
import 'package:minigames_minecraft/features/items/presentation/screens/edit_item_screen.dart';
import 'package:minigames_minecraft/features/items/presentation/screens/item_list_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ItemListScreen(),
    ),
    GoRoute(
      path: '/add-item',
      builder: (context, state) => const AddItemScreen(),
    ),
    GoRoute(
      path: '/edit-item/:itemId',
      builder: (context, state) {
        final itemId = state.pathParameters['itemId']!;
        return EditItemScreen(itemId: itemId);
      },
    ),
  ],
);
