enum ProductCategory {
  // This enum represents the different categories of products in the inventory. Each category is associated with a specific label that can be used for display purposes in the UI.
  beverages,
  food,
  personalCare;

  String get label {
    // This getter returns a human-readable label for each product category. It uses a switch statement to map each enum value to its corresponding label string.
    switch (this) {
      case ProductCategory.beverages:
        return 'Beverages';
      case ProductCategory.food:
        return 'Food';
      case ProductCategory.personalCare:
        return 'Personal Care';
    }
  }
}

enum StockStatus {
  // This enum represents the different stock statuses for a product in the inventory. Each status indicates the availability of the product based on its current stock level.
  ok,
  low,
  outOfStock;

  String get label {
    // This getter returns a human-readable label for each stock status. It uses a switch statement to map each enum value to its corresponding label string.
    switch (this) {
      case StockStatus.ok:
        return 'OK';
      case StockStatus.low:
        return 'Low';
      case StockStatus.outOfStock:
        return 'Out';
    }
  }
}

/// One row in the inventory list, e.g. "Nescafé 3in1, Beverages, 120 OK".
class ProductEntity {
  final String id;
  final String name;
  final ProductCategory category;
  final int currentStock;
  final int lowStockThreshold; // below this (but > 0) counts as "Low"

  const ProductEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.currentStock,
    required this.lowStockThreshold,
  });

  /// The entity decides its own status — same pattern as StockItemEntity in
  /// the dashboard feature. Widgets just ask `product.status`, they never
  /// re-implement this threshold logic themselves.
  StockStatus get status {
    if (currentStock <= 0) return StockStatus.outOfStock;
    if (currentStock <= lowStockThreshold) return StockStatus.low;
    return StockStatus.ok;
  }
}
