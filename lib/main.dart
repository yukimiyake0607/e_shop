import 'package:e_shop/firebase_options.dart';
import 'package:e_shop/src/app_bootstrap_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/src/app_bootstrap.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // URL内の#を削除する
  usePathUrlStrategy();
  // appBootstrapのインスタンスを作成
  final appBootstrap = AppBootstrap();
  // 全ての「フェイクリポジトリ」で構成されたコンテナを作成
  final container = await appBootstrap.createFirebaseProviderContainer();
  // 上記のコンテナを使用してルートウィジェットを作成
  final root = appBootstrap.createRootWidget(container: container);
  // アプリを起動
  runApp(root);
}
