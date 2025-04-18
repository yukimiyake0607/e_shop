import 'package:e_shop/src/features/products/data/products_repository.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:e_shop/src/features/products_admin/data/image_upload_repository.dart';
import 'package:e_shop/src/routing/app_router.dart';
import 'package:e_shop/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_product_upload_controller.g.dart';

@riverpod
class AdminProductUploadController extends _$AdminProductUploadController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<void> upload(Product product) async {
    try {
      state = const AsyncLoading();

      // Firebase Storageに画像をアップロード
      final downloadUrl = await ref
          .read(imageUploadRepositoryProvider)
          .uploadProductImageFromAsset(product.imageUrl, product.id);

      // Firestoreに商品情報を保存
      await ref
          .read(productsRepositoryProvider)
          .createProduct(product.id, downloadUrl);

      state = const AsyncData(null);

      ref
          .read(goRouterProvider)
          .goNamed(
            AppRoute.adminEditProduct.name,
            pathParameters: {'id': product.id},
          );
    } on Exception catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
    }
  }
}
