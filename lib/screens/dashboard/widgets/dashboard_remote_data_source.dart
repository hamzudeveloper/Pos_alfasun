

import 'package:alfasun_pos/screens/dashboard/widgets/sales_trend_range.dart';

/// Stands in for a real API call for now. Swap the body of [fetchDashboardJson]
/// for an actual `http.get(...)` later — nothing outside this file needs to change,
/// because the repository only talks to this class through its method signature.
class DashboardRemoteDataSource {
  Future<Map<String, dynamic>> fetchDashboardJson(SalesTrendRange range) async {
    await Future.delayed(const Duration(milliseconds: 600)); // simulate network delay

    return {
      'managerName': 'Juan',
      'lastSyncedAt': DateTime.now().toIso8601String(),
      'isOnline': true,
      'totalSales': {'value': 86240.0, 'changePercent': 12.5},
      'totalProfit': {'value': 24380.0, 'changePercent': 8.2},
      'profitMargin': {'value': 28.3, 'changePercent': -1.4, 'isPercentValue': true},
      'totalOrders': {'value': 1247.0, 'changePercent': 18.9},
      'salesTrend': _salesTrendFor(range),
      'lowStockItems': [
        {'name': 'Tide Powder 1kg', 'currentStock': 8, 'maxStock': 50},
        {'name': 'Ariel Detergent', 'currentStock': 3, 'maxStock': 40},
        {'name': 'Milo Activ-Go', 'currentStock': 15, 'maxStock': 80},
      ],
    };
  }

  List<Map<String, dynamic>> _salesTrendFor(SalesTrendRange range) {
    switch (range) {
      case SalesTrendRange.today:
        return [
          {'label': '9am', 'value': 4000.0},
          {'label': '12pm', 'value': 9500.0},
          {'label': '3pm', 'value': 7200.0},
          {'label': '6pm', 'value': 12800.0},
          {'label': '9pm', 'value': 6400.0},
        ];
      case SalesTrendRange.week:
        return [
          {'label': 'Mon', 'value': 12000.0},
          {'label': 'Tue', 'value': 10200.0},
          {'label': 'Wed', 'value': 9000.0},
          {'label': 'Thu', 'value': 22800.0},
          {'label': 'Fri', 'value': 30500.0},
          {'label': 'Sat', 'value': 32000.0},
          {'label': 'Sun', 'value': 18000.0},
        ];
      case SalesTrendRange.month:
        return [
          {'label': 'Week 1', 'value': 62000.0},
          {'label': 'Week 2', 'value': 71000.0},
          {'label': 'Week 3', 'value': 58000.0},
          {'label': 'Week 4', 'value': 86240.0},
        ];
    }
  }
}
