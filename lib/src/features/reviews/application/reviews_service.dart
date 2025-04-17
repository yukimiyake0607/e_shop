import 'package:e_shop/src/features/authentication/data/auth_repository.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:e_shop/src/features/reviews/data/reviews_repository.dart';
import 'package:e_shop/src/features/reviews/domain/review.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reviews_service.g.dart';

class ReviewsService {
  ReviewsService(this._ref);
  final Ref _ref;

  Future<void> submitReview({
    required ProductID productId,
    required Review review,
  }) {
    // TODO: Implement with Firebase
    throw UnimplementedError();
  }
}

@riverpod
ReviewsService reviewsService(Ref ref) {
  return ReviewsService(ref);
}

/// Check if a product was previously reviewed by the user
@riverpod
Future<Review?> userReviewFuture(Ref ref, ProductID productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(reviewsRepositoryProvider)
        .fetchUserReview(productId, user.uid);
  } else {
    return Future.value(null);
  }
}

/// Check if a product was previously reviewed by the user
@riverpod
Stream<Review?> userReviewStream(Ref ref, ProductID productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(reviewsRepositoryProvider)
        .watchUserReview(productId, user.uid);
  } else {
    return Stream.value(null);
  }
}
