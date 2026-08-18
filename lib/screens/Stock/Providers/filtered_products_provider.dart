// import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
// import 'package:alfasun_pos/Screens/Stock/Widgets/stock_filter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'inventory_injection_provider.dart';
// import 'products_provider.dart';
// import 'stock_filter_provider.dart';
// import 'stock_search_query_provider.dart';

// filtered_products_provider.dart
// ignore_for_file: avoid_print

// This is a plain Provider (not FutureProvider) because it doesn't fetch
// anything itself — it just recombines data that's already loaded.
// `productsAsync.whenData(...)` transforms the successful case only,
// letting loading/error states pass straight through untouched, so the
// screen can still show a spinner or error message correctly.
//
// Because this watches productsProvider, stockSearchQueryProvider, AND
// stockFilterProvider, it recomputes whenever ANY of the three changes —
// typing in the search box or tapping a filter chip both trigger a fresh
// filtered list, with no network refetch (the data's already in memory).
// final filteredProductsProvider =
//     Provider.autoDispose<AsyncValue<List<ProductEntity>>>((ref) {
//       final productsAsync = ref.watch(productsProvider);
//       final query = ref.watch(stockSearchQueryProvider);
//       final filter = ref.watch(stockFilterProvider);
//       final searchAndFilter = ref.watch(searchAndFilterProductsProvider);

//       return productsAsync.whenData((products) {
//         if (searchAndFilter == filter.label && query.isEmpty) return products;
//         return products
//             .where((product) => product.status.name == filter.name)
//             .toList();
//       });
//     });

// final filteredPurchaseOrdersProvider =
//     Provider.autoDispose<AsyncValue<List<PurchaseOrderEntity>>>((ref) {
//       final ordersAsync = ref.watch(purchaseOrdersProvider);
//       final filter = ref.watch(purchaseFilterProvider);

//       return ordersAsync.whenData((orders) {
//         if (filter == PurchaseFilter.all) return orders;
//         return orders
//             .where((order) => order.status.name == filter.name)
//             .toList();
//       });
//     });

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
final filteredProductsProvider =
    Provider<AsyncValue<List<ProductEntity>>>((ref) {
      final productsAsync = ref.watch(productsProvider);
      final query = ref.watch(stockSearchQueryProvider);
      final filter = ref.watch(stockFilterProvider);
      final searchAndFilter = ref.watch(searchAndFilterProductsProvider);

      // searchAndFilter is a CALLABLE object (SearchAndFilterProducts has a
      // `call()` method) — you use it by invoking it with the data it needs,
      // not by comparing it to anything with ==.
      return productsAsync.whenData((products) {
        print("Products: ${products.length}");
        print('querry: $query');
        print('filter: $filter');
        print('productAsync: $productsAsync');
        return searchAndFilter(products, query: query, filter: filter);
      });
    });
