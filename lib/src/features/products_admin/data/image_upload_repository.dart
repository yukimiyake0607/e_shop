import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_repository.g.dart';

/// Class for uploading images to Firebase Storage
class ImageUploadRepository {
  ImageUploadRepository(this._storage);
  final FirebaseStorage _storage;

  /// Upload an image asset to Firebase Storage and returns the download URL
  Future<String> uploadProductImageFromAsset(
    String assetPath,
    ProductID productId,
  ) async {
    // load asset byte data from bundle
    final byteData = await rootBundle.load(assetPath);

    // Extract filename
    // Example name: assets/products/bruschetta-plate.jpg
    final components = assetPath.split('/');
    final filename = components[2];
    // upload to Firebase Storage
    final result = await _uploadAsset(byteData, filename);

    // return download URL
    return result.ref.getDownloadURL();
  }

  UploadTask _uploadAsset(ByteData byteData, String filename) {
    final bytes = byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );
    final ref = _storage.ref('products/$filename');
    return ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
  }

  /// Delete the product image from Firebase storage
  Future<void> deleteProductImage(String imageUrl) {
    // * This line will throw an exception when running with the Firebase local emulator.
    // * 'parts != null': url could not be parsed, ensure it's a valid storage url
    // * More info here: https://github.com/firebase/flutterfire/issues/7019
    return _storage.refFromURL(imageUrl).delete();
  }
}

@riverpod
ImageUploadRepository imageUploadRepository(Ref ref) {
  return ImageUploadRepository(FirebaseStorage.instance);
}
