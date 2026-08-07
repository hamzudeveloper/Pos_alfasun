

import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/stock_filter.dart';

/// This one doesn't touch the repository at all — it's pure logic over data
/// you already have. It's still a use case (not a widget helper function)
/// because "what counts as a search match" and "what counts as a filter
/// match" are business rules, not UI rules. Keeping it here means it's
/// testable on its own, with no Flutter or Riverpod involved.
class SearchAndFilterProducts {
  List<ProductEntity> call(
    List<ProductEntity> products, {
    required String query,
    required StockFilter filter,
  }) {
    final trimmedQuery = query.trim().toLowerCase();

    return products.where((product) {
      final matchesQuery = trimmedQuery.isEmpty ||
          product.name.toLowerCase().contains(trimmedQuery) ||
          product.category.label.toLowerCase().contains(trimmedQuery);

      final matchesFilter = switch (filter) {
        StockFilter.all => true,
        StockFilter.lowStock => product.status == StockStatus.low,
        StockFilter.outOfStock => product.status == StockStatus.outOfStock,
      };

      return matchesQuery && matchesFilter;
    }).toList();
  }
}
