import 'package:e_shop/src/features/products/presentation/products_list/products_search_query_notifier.dart';
import 'package:e_shop/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Search field used to filter products by name
class ProductsSearchTextField extends ConsumerStatefulWidget {
  const ProductsSearchTextField({super.key});

  @override
  ConsumerState<ProductsSearchTextField> createState() =>
      _ProductsSearchTextFieldState();
}

class _ProductsSearchTextFieldState
    extends ConsumerState<ProductsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          // TODO: Re-enable once we implement search again
          enabled: false,
          autofocus: false,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            hintText: 'Search products'.hardcoded,
            icon: const Icon(Icons.search),
            suffixIcon:
                value.text.isNotEmpty
                    ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        ref
                            .read(productsSearchQueryNotifierProvider.notifier)
                            .setQuery('');
                      },
                      icon: const Icon(Icons.clear),
                    )
                    : null,
          ),
          onChanged:
              (text) => ref
                  .read(productsSearchQueryNotifierProvider.notifier)
                  .setQuery(text),
        );
      },
    );
  }
}
