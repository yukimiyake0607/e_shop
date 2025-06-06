import 'dart:math';

import 'package:collection/collection.dart';
import 'package:e_shop/src/features/authentication/data/auth_repository.dart';
import 'package:e_shop/src/features/cart/data/local/local_cart_repository.dart';
import 'package:e_shop/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:e_shop/src/features/cart/domain/cart.dart';
import 'package:e_shop/src/features/cart/domain/item.dart';
import 'package:e_shop/src/features/cart/domain/mutable_cart.dart';
import 'package:e_shop/src/features/products/data/products_repository.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_service.g.dart';

class CartService {
  CartService(this.ref);
  final Ref ref;

  AuthRepository get authRepository => ref.read(authRepositoryProvider);
  RemoteCartRepository get remoteCartRepository =>
      ref.read(remoteCartRepositoryProvider);
  LocalCartRepository get localCartRepository =>
      ref.read(localCartRepositoryProvider);

  /// fetch the cart from the local or remote repository
  /// depending on the user auth state
  Future<Cart> _fetchCart() {
    final user = authRepository.currentUser;
    if (user != null) {
      return remoteCartRepository.fetchCart(user.uid);
    } else {
      return localCartRepository.fetchCart();
    }
  }

  /// save the cart to the local or remote repository
  /// depending on the user auth state
  Future<void> _setCart(Cart cart) async {
    final user = authRepository.currentUser;
    if (user != null) {
      await remoteCartRepository.setCart(user.uid, cart);
    } else {
      await localCartRepository.setCart(cart);
    }
  }

  /// sets an item in the local or remote cart depending on the user auth state
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
  }

  /// adds an item in the local or remote cart depending on the user auth state
  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.addItem(item);
    await _setCart(updated);
  }

  /// removes an item from the local or remote cart depending on the user auth
  /// state
  Future<void> removeItemById(ProductID productId) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productId);
    await _setCart(updated);
  }
}

@riverpod
CartService cartService(Ref ref) {
  return CartService(ref);
}

@riverpod
Stream<Cart> cart(Ref ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(remoteCartRepositoryProvider).watchCart(user.uid);
  } else {
    return ref.watch(localCartRepositoryProvider).watchCart();
  }
}

@riverpod
int cartItemsCount(Ref ref) {
  return ref
      .watch(cartProvider)
      .maybeMap(data: (cart) => cart.value.items.length, orElse: () => 0);
}

@riverpod
Future<double> cartTotal(Ref ref) async {
  final cart = await ref.watch(cartProvider.future);
  final productsList = await ref.watch(productsListStreamProvider.future);
  if (cart.items.isNotEmpty && productsList.isNotEmpty) {
    var total = 0.0;
    for (final item in cart.items.entries) {
      final product = productsList.firstWhereOrNull(
        (product) => product.id == item.key,
      );
      if (product != null) {
        total += product.price * item.value;
      }
    }
    return total;
  } else {
    return 0.0;
  }
}

@riverpod
int itemAvailableQuantity(Ref ref, Product product) {
  final cart = ref.watch(cartProvider).value;
  if (cart != null) {
    // get the current quantity for the given product in the cart
    final quantity = cart.items[product.id] ?? 0;
    // subtract it from the product available quantity
    return max(0, product.availableQuantity - quantity);
  } else {
    return product.availableQuantity;
  }
}
