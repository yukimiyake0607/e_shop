import 'package:e_shop/src/common_widgets/async_value_widget.dart';
import 'package:e_shop/src/constants/breakpoints.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:e_shop/src/features/reviews/data/reviews_repository.dart';
import 'package:e_shop/src/features/reviews/presentation/product_reviews/product_review_card.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/src/common_widgets/responsive_center.dart';
import 'package:e_shop/src/constants/app_sizes.dart';
import 'package:e_shop/src/features/reviews/domain/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows the list of reviews for a given product ID
class ProductReviewsList extends ConsumerWidget {
  const ProductReviewsList({super.key, required this.productId});
  final ProductID productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsValue = ref.watch(productReviewsProvider(productId));
    return AsyncValueSliverWidget<List<Review>>(
      value: reviewsValue,
      data:
          (reviews) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => ResponsiveCenter(
                maxContentWidth: Breakpoint.tablet,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p16,
                  vertical: Sizes.p8,
                ),
                child: ProductReviewCard(reviews[index]),
              ),
              childCount: reviews.length,
            ),
          ),
    );
  }
}
