import 'package:e_shop/src/common_widgets/async_value_widget.dart';
import 'package:e_shop/src/features/products/data/products_repository.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:e_shop/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/src/common_widgets/custom_image.dart';
import 'package:e_shop/src/constants/app_sizes.dart';
import 'package:e_shop/src/features/cart/domain/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows an individual order item, including price and quantity.
class OrderItemListTile extends ConsumerWidget {
  const OrderItemListTile({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productValue = ref.watch(productStreamProvider(item.productId));
    return AsyncValueWidget<Product?>(
      value: productValue,
      data:
          (product) => Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CustomImage(imageUrl: product!.imageUrl),
                ),
                gapW8,
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title),
                      gapH12,
                      Text(
                        'Quantity: ${item.quantity}'.hardcoded,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
