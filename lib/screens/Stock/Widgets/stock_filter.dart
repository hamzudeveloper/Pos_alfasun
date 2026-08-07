enum StockFilter {
  all,
  lowStock,
  outOfStock;

  String get label {
    switch (this) {
      case StockFilter.all:
        return 'All';
      case StockFilter.lowStock:
        return 'Low Stock';
      case StockFilter.outOfStock:
        return 'Out of Stock';
    }
  }
}
