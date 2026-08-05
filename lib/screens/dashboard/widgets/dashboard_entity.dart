import 'package:alfasun_pos/screens/dashboard/widgets/sales_point_entity.dart';

import 'stock_item_entity.dart';

/// A single stat like "Total Sales: Rs 86,240, +12.5%".
/// Reused for sales, profit, margin, and orders — same shape, different data.
class StatEntity {
  final double value;
  final double changePercent; // positive = up, negative = down
  final bool isPercentValue; // true for "Profit Margin" which is itself a %

  const StatEntity({
    required this.value,
    required this.changePercent,
    this.isPercentValue = false,
  });

  bool get isPositive => changePercent >= 0;
}

/// Everything the Manager Dashboard screen needs, fetched in one call.
/// This is the ONLY thing the presentation layer depends on from the domain —
/// it has no idea whether the data came from an API, a local DB, or mock data.
class DashboardEntity {
  final String managerName;
  final DateTime lastSyncedAt;
  final bool isOnline;

  final StatEntity totalSales;
  final StatEntity totalProfit;
  final StatEntity profitMargin;
  final StatEntity totalOrders;

  final List<SalesPointEntity> salesTrend;
  final List<StockItemEntity> lowStockItems;

  const DashboardEntity({
    required this.managerName,
    required this.lastSyncedAt,
    required this.isOnline,
    required this.totalSales,
    required this.totalProfit,
    required this.profitMargin,
    required this.totalOrders,
    required this.salesTrend,
    required this.lowStockItems,
  });
}
