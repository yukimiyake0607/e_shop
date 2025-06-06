import 'package:e_shop/src/features/products/data/test_products.dart';
import 'package:e_shop/src/features/authentication/domain/app_user.dart';
import 'package:e_shop/src/features/reviews/application/fake_reviews_service.dart';
import 'package:e_shop/src/features/reviews/application/reviews_service.dart';
import 'package:e_shop/src/features/reviews/domain/review.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  const testUser = AppUser(uid: 'abc', email: 'abc@test.com');
  final testProductId = kTestProducts[0].id;
  final testReview = Review(
    rating: 5,
    comment: '',
    date: DateTime(2022, 7, 31),
  );
  late MockAuthRepository authRepository;
  late MockReviewsRepository reviewsRepository;
  late MockProductsRepository productsRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    reviewsRepository = MockReviewsRepository();
    productsRepository = MockProductsRepository();
  });

  ReviewsService makeReviewsService() {
    return FakeReviewsService(
      fakeProductsRepository: productsRepository,
      authRepository: authRepository,
      reviewsRepository: reviewsRepository,
    );
  }

  group('submitReview', () {
    test('null user, throws', () {
      // setup
      when(() => authRepository.currentUser).thenReturn(null);
      final reviewsService = makeReviewsService();
      // run
      expect(
        () => reviewsService.submitReview(
          productId: testProductId,
          review: testReview,
        ),
        throwsAssertionError,
      );
    });
    test('non null user, sets review', () async {
      // setup
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(
        () => reviewsRepository.setReview(
          productId: testProductId,
          uid: testUser.uid,
          review: testReview,
        ),
      ).thenAnswer((_) => Future.value());
      when(
        () => reviewsRepository.fetchReviews(testProductId),
      ).thenAnswer((_) => Future.value([]));
      when(
        () => productsRepository.getProduct(testProductId),
      ).thenReturn(kTestProducts[0]);
      when(
        () => productsRepository.setProduct(kTestProducts[0]),
      ).thenAnswer((_) => Future.value());
      final reviewsService = makeReviewsService();
      // run
      await reviewsService.submitReview(productId: '1', review: testReview);
      // verify
      verify(() => authRepository.currentUser).called(1);
      verify(
        () => reviewsRepository.setReview(
          productId: testProductId,
          uid: testUser.uid,
          review: testReview,
        ),
      ).called(1);
    });
  });
}
