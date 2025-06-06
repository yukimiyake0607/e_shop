import 'package:e_shop/src/features/authentication/domain/app_user.dart';
import 'package:e_shop/src/features/orders/data/orders_repository.dart';
import 'package:e_shop/src/features/orders/domain/order.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:e_shop/src/utils/delay.dart';
import 'package:e_shop/src/utils/in_memory_store.dart';

class FakeOrdersRepository implements OrdersRepository {
  FakeOrdersRepository({this.addDelay = true});
  final bool addDelay;

  /// A map of all the orders placed by each user, where:
  /// - key: user ID
  /// - value: list of orders for that user
  final _orders = InMemoryStore<Map<UserID, List<Order>>>({});

  /// A stream that returns all the orders for a given user, ordered by date
  /// Only user orders that match the given productId will be returned.
  /// If a productId is not passed, all user orders will be returned.
  @override
  Stream<List<Order>> watchUserOrders(UserID uid, {ProductID? productId}) {
    return _orders.stream.map((ordersData) {
      final ordersList = ordersData[uid] ?? [];
      ordersList.sort((lhs, rhs) => rhs.orderDate.compareTo(lhs.orderDate));
      if (productId != null) {
        return ordersList
            .where((order) => order.items.keys.contains(productId))
            .toList();
      } else {
        return ordersList;
      }
    });
  }

  // A method to add a new order to the list for a given user
  Future<void> addOrder(UserID uid, Order order) async {
    await delay(addDelay);
    final value = _orders.value;
    final userOrders = value[uid] ?? [];
    userOrders.add(order);
    value[uid] = userOrders;
    _orders.value = value;
  }
}
