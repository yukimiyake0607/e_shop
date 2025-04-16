import 'package:e_shop/src/features/products/data/fake_products_repository.dart';
import 'package:e_shop/src/features/products/domain/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_search_query_notifier.g.dart';

/// A simple notifier class to keep track of the search query
@riverpod
class ProductsSearchQueryNotifier extends _$ProductsSearchQueryNotifier {
  /// By default, return an empty query
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

/// A provider that returns the search results for the current search query
@riverpod
Future<List<Product>> productsSearchResults(Ref ref) {
  final searchQuery = ref.watch(productsSearchQueryNotifierProvider);
  return ref.watch(productsListSearchProvider(searchQuery).future);
}
