// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCQEo5pVUBhfvFkgC20GBFf4apg_qbZw_s',
    appId: '1:785108592185:web:5bb63274394b8390034fe8',
    messagingSenderId: '785108592185',
    projectId: 'e-shop-23bf8',
    authDomain: 'e-shop-23bf8.firebaseapp.com',
    storageBucket: 'e-shop-23bf8.firebasestorage.app',
    measurementId: 'G-SXG5V7B09J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgP3pbr28vkT1k7a1lh0lP4UYL5NlU2BY',
    appId: '1:785108592185:android:88207154b89b264b034fe8',
    messagingSenderId: '785108592185',
    projectId: 'e-shop-23bf8',
    storageBucket: 'e-shop-23bf8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3D5uTaovhfQK2u_RFsInTkTa5DGjcGEU',
    appId: '1:785108592185:ios:35db2d114d6f6c8f034fe8',
    messagingSenderId: '785108592185',
    projectId: 'e-shop-23bf8',
    storageBucket: 'e-shop-23bf8.firebasestorage.app',
    iosBundleId: 'com.example.eShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3D5uTaovhfQK2u_RFsInTkTa5DGjcGEU',
    appId: '1:785108592185:ios:35db2d114d6f6c8f034fe8',
    messagingSenderId: '785108592185',
    projectId: 'e-shop-23bf8',
    storageBucket: 'e-shop-23bf8.firebasestorage.app',
    iosBundleId: 'com.example.eShop',
  );
}
