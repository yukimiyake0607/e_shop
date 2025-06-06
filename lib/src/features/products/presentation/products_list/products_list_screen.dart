import 'package:e_shop/src/features/products/presentation/home_app_bar/home_app_bar.dart';
import 'package:e_shop/src/features/products/presentation/products_list/sliver_products_grid.dart';
import 'package:e_shop/src/features/products/presentation/products_list/products_search_text_field.dart';
import 'package:e_shop/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/src/common_widgets/responsive_center.dart';
import 'package:e_shop/src/constants/app_sizes.dart';
import 'package:go_router/go_router.dart';

/// Shows the list of products with a search field at the top.
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: ProductsSearchTextField(),
          ),
          SliverProductsGrid(
            onPressed:
                (context, productId) => context.goNamed(
                  AppRoute.product.name,
                  pathParameters: {'id': productId},
                ),
          ),
        ],
      ),
    );
  }
}
