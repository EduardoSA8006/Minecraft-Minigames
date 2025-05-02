import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/itens/data/item_providers.dart';
import '../../features/itens/domain/item_repository.dart';

final itemRepositoryGlobalProvider = Provider<ItemRepository>((ref) {
  return ref.watch(itemRepositoryProvider);
});
