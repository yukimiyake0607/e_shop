import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:e_shop/src/features/reviews/application/reviews_service.dart';
import 'package:e_shop/src/features/reviews/domain/review.dart';
import 'package:e_shop/src/utils/current_date_provider.dart';
import 'package:e_shop/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leave_review_controller.g.dart';

@riverpod
class LeaveReviewController extends _$LeaveReviewController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // nothing to do
  }

  Future<void> submitReview({
    Review? previousReview,
    required ProductID productId,
    required double rating,
    required String comment,
    required void Function() onSuccess,
  }) async {
    // * only submit if the rating is new or it has changed
    if (previousReview == null ||
        rating != previousReview.rating ||
        comment != previousReview.comment) {
      final currentDateBuilder = ref.read(currentDateBuilderProvider);
      final reviewsService = ref.read(reviewsServiceProvider);
      final review = Review(
        rating: rating,
        comment: comment,
        date: currentDateBuilder(),
      );
      state = const AsyncLoading();
      final newState = await AsyncValue.guard(
        () => reviewsService.submitReview(productId: productId, review: review),
      );
      if (mounted) {
        // * only set the state if the controller hasn't been disposed
        state = newState;
        if (state.hasError == false) {
          onSuccess();
        }
      }
    } else {
      onSuccess();
    }
  }
}
