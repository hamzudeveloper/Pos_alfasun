/// Stands in for a real API call — swap fetchPurchaseOrdersJson's body for
/// a real network call later, nothing else needs to change.
class PurchaseRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchPurchaseOrdersJson() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      {
        'id': 'po1',
        'poNumber': 'PO-2024-001',
        'vendorName': 'SM Trading Corp',
        'orderDate': '2024-01-10',
        'itemsDescription': 'Beverages, Snacks (x45 units)',
        'totalAmount': 12400.0,
        'amountPaid': 0.0,
      },
      {
        'id': 'po2',
        'poNumber': 'PO-2024-002',
        'vendorName': 'NutriFood Inc.',
        'orderDate': '2024-01-12',
        'itemsDescription': 'Canned goods (x30 units)',
        'totalAmount': 8750.0,
        'amountPaid': 3500.0,
      },
      {
        'id': 'po3',
        'poNumber': 'PO-2024-003',
        'vendorName': 'CleanPro Dist.',
        'orderDate': '2024-01-08',
        'itemsDescription': 'Cleaning products (x20 units)',
        'totalAmount': 5600.0,
        'amountPaid': 5600.0,
      },
      {
        'id': 'po4',
        'poNumber': 'PO-2024-004',
        'vendorName': 'CarePhil Corp',
        'orderDate': '2024-01-14',
        'itemsDescription': 'Personal care items (x25 units)',
        'totalAmount': 9200.0,
        'amountPaid': 0.0,
      },
      {
        'id': 'po5',
        'poNumber': 'PO-2024-005',
        'vendorName': 'DrinksPH Co.',
        'orderDate': '2024-01-13',
        'itemsDescription': 'Beverages assorted (x60 units)',
        'totalAmount': 6800.0,
        'amountPaid': 3400.0,
      },
    ];
  }
}
