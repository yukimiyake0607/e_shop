import 'dart:math';

import 'package:e_shop/src/features/cart/application/cart_service.dart';
import 'package:e_shop/src/features/cart/presentation/add_to_cart/add_to_cart_controller.dart';
import 'package:e_shop/src/localization/string_hardcoded.dart';
import 'package:e_shop/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/src/features/cart/presentation/item_quantity_selector.dart';
import 'package:e_shop/src/common_widgets/primary_button.dart';
import 'package:e_shop/src/constants/app_sizes.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that shows an [ItemQuantitySelector] along with a [PrimaryButton]
/// to add the selected quantity of the item to the cart.
class AddToCartWidget extends ConsumerWidget {
  const AddToCartWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      addToCartControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final availableQuantity = ref.watch(itemAvailableQuantityProvider(product));
    final state = ref.watch(addToCartControllerProvider);
    final quantity = ref.watch(itemQuantityControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity:'.hardcoded),
            ItemQuantitySelector(
              quantity: quantity,
              // let the user choose up to the available quantity or
              // 10 items at most
              maxQuantity: min(availableQuantity, 10),
              onChanged:
                  state.isLoading
                      ? null
                      : (quantity) => ref
                          .read(itemQuantityControllerProvider.notifier)
                          .updateQuantity(quantity),
            ),
          ],
        ),
        gapH8,
        const Divider(),
        gapH8,
        PrimaryButton(
          isLoading: state.isLoading,
          // only enable the button if there is enough stock
          onPressed:
              availableQuantity > 0
                  ? () => ref
                      .read(addToCartControllerProvider.notifier)
                      .addItem(product.id)
                  : null,
          text:
              availableQuantity > 0
                  ? 'Add to Cart'.hardcoded
                  : 'Out of Stock'.hardcoded,
        ),
        if (product.availableQuantity > 0 && availableQuantity == 0) ...[
          gapH8,
          Text(
            'Already added to cart'.hardcoded,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
