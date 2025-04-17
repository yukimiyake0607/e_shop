import 'package:e_shop/src/features/authentication/domain/app_user.dart';
import 'package:e_shop/src/features/orders/domain/order.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_repository.g.dart';

// TODO: Implement with Firebase
abstract class OrdersRepository {
  Stream<List<Order>> watchUserOrders(UserID uid, {ProductID? productId});
}

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(Ref ref) {
  // TODO: create and return repository
  throw UnimplementedError();
}
