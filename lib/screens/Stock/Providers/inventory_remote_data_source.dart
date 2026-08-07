/// Stands in for a real API/database call — swap the body of
/// [fetchProductsJson] for an actual network call later; nothing outside
/// this file needs to change.
class InventoryRemoteDataSource { 
  // This class simulates a remote data source for fetching product data. 
  //It provides a method to fetch product data in JSON format, 
  //which can later be replaced with an actual API or database call.
  Future<List<Map<String, dynamic>>> fetchProductsJson() async {
    // This method simulates fetching product data in JSON format from a remote source.
    await Future.delayed(const Duration(milliseconds: 500));
  // The method introduces a delay of 500 milliseconds to simulate network latency.
  // The method returns a list of maps, where each map represents a product with its attributes such as id, name, category, current stock, and low stock threshold.
    return [
      {'id': 'p1', 'name': 'Nescafé 3in1', 'category': 'beverages', 'currentStock': 120, 'lowStockThreshold': 30},
      {'id': 'p2', 'name': 'Milo Activ-Go', 'category': 'beverages', 'currentStock': 45, 'lowStockThreshold': 20},
      {'id': 'p3', 'name': 'Lucky Me Pancit', 'category': 'food', 'currentStock': 200, 'lowStockThreshold': 40},
      {'id': 'p4', 'name': 'Century Tuna', 'category': 'food', 'currentStock': 89, 'lowStockThreshold': 25},
      {'id': 'p5', 'name': 'Palmolive Shampoo', 'category': 'personalCare', 'currentStock': 67, 'lowStockThreshold': 20},
      {'id': 'p6', 'name': 'Colgate Total', 'category': 'personalCare', 'currentStock': 52, 'lowStockThreshold': 20},
      {'id': 'p7', 'name': 'Tide Powder 1kg', 'category': 'personalCare', 'currentStock': 8, 'lowStockThreshold': 15},
      {'id': 'p8', 'name': 'Ariel Detergent', 'category': 'personalCare', 'currentStock': 3, 'lowStockThreshold': 10},
      {'id': 'p9', 'name': 'Kopiko Blanca', 'category': 'beverages', 'currentStock': 0, 'lowStockThreshold': 20},
      {'id': 'p10', 'name': 'Argentina Corned Beef', 'category': 'food', 'currentStock': 5, 'lowStockThreshold': 15},
      {'id': 'p11', 'name': 'Head & Shoulders', 'category': 'personalCare', 'currentStock': 0, 'lowStockThreshold': 15},
      {'id': 'p12', 'name': 'Nissin Cup Noodles', 'category': 'food', 'currentStock': 150, 'lowStockThreshold': 30},
    ];
  }
}
