enum PurchaseFilter {
  all,
  due,
  partial,
  paid;

  String get label {
    switch (this) {
      case PurchaseFilter.all:
        return 'All';
      case PurchaseFilter.due:
        return 'Due';
      case PurchaseFilter.partial:
        return 'Partial';
      case PurchaseFilter.paid:
        return 'Paid';
    }
  }
}
