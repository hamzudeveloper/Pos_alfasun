enum PurchaseStatus {
  due,
  partial,
  paid;

  String get label {
    switch (this) {
      case PurchaseStatus.due:
        return 'Due';
      case PurchaseStatus.partial:
        return 'Partial';
      case PurchaseStatus.paid:
        return 'Paid';
    }
  }
}

/// One row on the Purchases screen. Status, remaining balance, and payment
/// progress are all DERIVED from totalAmount/amountPaid — not stored
/// separately — so they can never disagree with each other. Same pattern
/// as StockItemEntity.severity and ProductEntity.status.
class PurchaseOrderEntity {
  final String id;
  final String poNumber;
  final String vendorName;
  final DateTime orderDate;
  final String itemsDescription; // e.g. "Beverages, Snacks (x45 units)"
  final double totalAmount;
  final double amountPaid;

  const PurchaseOrderEntity({
    required this.id,
    required this.poNumber,
    required this.vendorName,
    required this.orderDate,
    required this.itemsDescription,
    required this.totalAmount,
    required this.amountPaid,
  });

  double get remaining => totalAmount - amountPaid;

  /// 0.0 - 1.0, how much of the total has been paid so far.
  double get percentPaid => totalAmount <= 0 ? 0 : (amountPaid / totalAmount).clamp(0, 1);

  PurchaseStatus get status {
    if (amountPaid <= 0) return PurchaseStatus.due;
    if (remaining <= 0) return PurchaseStatus.paid;
    return PurchaseStatus.partial;
  }
}
