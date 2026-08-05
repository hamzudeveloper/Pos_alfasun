enum StockSeverity { critical, low, warning }

/// One row in the "Low Stock Alert" list, e.g. "Ariel Detergent 3/40".
class StockItemEntity {
  final String name;
  final int currentStock;
  final int maxStock;

  const StockItemEntity({
    required this.name,
    required this.currentStock,
    required this.maxStock,
  });

  double get ratio => maxStock == 0 ? 0 : currentStock / maxStock;

  /// The item itself decides how severe its stock level is — callers just
  /// ask `item.severity` instead of re-implementing this threshold logic
  /// in every widget that shows a stock row (single responsibility).
  StockSeverity get severity {
    if (ratio < 0.10) return StockSeverity.critical;
    if (ratio < 0.20) return StockSeverity.low;
    return StockSeverity.warning;
  }
}
