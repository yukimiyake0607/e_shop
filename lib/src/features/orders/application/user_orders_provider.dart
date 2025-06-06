import 'package:e_shop/src/features/authentication/data/auth_repository.dart';
import 'package:e_shop/src/features/orders/data/orders_repository.dart';
import 'package:e_shop/src/features/orders/domain/order.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_orders_provider.g.dart';

/// Watch the list of user orders
/// NOTE: Only watch this provider if the user is signed in.
@riverpod
Stream<List<Order>> userOrders(Ref ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(ordersRepositoryProvider).watchUserOrders(user.uid);
  } else {
    // If the user is null, return an empty list (no orders)
    return Stream.value([]);
  }
}

/// Check if a product was previously purchased by the user
@riverpod
Stream<List<Order>> matchingUserOrders(Ref ref, ProductID productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(ordersRepositoryProvider)
        .watchUserOrders(user.uid, productId: productId);
  } else {
    // If the user is null, return an empty list (no orders)
    return Stream.value([]);
  }
}
