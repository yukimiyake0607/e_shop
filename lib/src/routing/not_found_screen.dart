import 'package:e_shop/src/localization/string_hardcoded.dart';
import 'package:e_shop/src/common_widgets/empty_placeholder_widget.dart';
import 'package:flutter/material.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(message: '404 - Page not found!'.hardcoded),
    );
  }
}
