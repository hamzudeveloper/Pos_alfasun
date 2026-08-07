import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'inventory_injection_provider.dart';
import 'products_provider.dart';
import 'stock_filter_provider.dart';
import 'stock_search_query_provider.dart';

/// This is a plain Provider (not FutureProvider) because it doesn't fetch
/// anything itself — it just recombines data that's already loaded.
/// `productsAsync.whenData(...)` transforms the successful case only,
/// letting loading/error states pass straight through untouched, so the
/// screen can still show a spinner or error message correctly.
///
/// Because this watches productsProvider, stockSearchQueryProvider, AND
/// stockFilterProvider, it recomputes whenever ANY of the three changes —
/// typing in the search box or tapping a filter chip both trigger a fresh
/// filtered list, with no network refetch (the data's already in memory).
final filteredProductsProvider = Provider.autoDispose<AsyncValue<List<ProductEntity>>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final query = ref.watch(stockSearchQueryProvider);
  final filter = ref.watch(stockFilterProvider);
  final searchAndFilter = ref.watch(searchAndFilterProductsProvider);

  // TEMP DEBUG — remove once search/filter is confirmed working.
  // ignore: avoid_print
  print('[filteredProductsProvider] query="$query" filter=$filter productsAsync=${productsAsync.runtimeType}');

  return productsAsync.whenData((products) {
    final result = searchAndFilter(products, query: query, filter: filter);
    // ignore: avoid_print
    print('[filteredProductsProvider] ${products.length} -> ${result.length} results');
    return result;
  });
});