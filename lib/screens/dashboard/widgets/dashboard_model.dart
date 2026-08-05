

import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_entity.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/sales_point_entity.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/stock_item_entity.dart';

/// DashboardModel extends DashboardEntity — it IS a DashboardEntity, just with
/// the added ability to parse itself from JSON. This keeps the domain entity
/// completely free of any "data format" concerns (no fromJson in domain/),
/// while the rest of the app can keep treating it as a plain DashboardEntity.
class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.managerName,
    required super.lastSyncedAt,
    required super.isOnline,
    required super.totalSales,
    required super.totalProfit,
    required super.profitMargin,
    required super.totalOrders,
    required super.salesTrend,
    required super.lowStockItems,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      managerName: json['managerName'] as String,
      lastSyncedAt: DateTime.parse(json['lastSyncedAt'] as String),
      isOnline: json['isOnline'] as bool,
      totalSales: _statFromJson(json['totalSales']),
      totalProfit: _statFromJson(json['totalProfit']),
      profitMargin: _statFromJson(json['profitMargin']),
      totalOrders: _statFromJson(json['totalOrders']),
      salesTrend: (json['salesTrend'] as List)
          .map((e) => SalesPointEntity(
                label: e['label'] as String,
                value: (e['value'] as num).toDouble(),
              ))
          .toList(),
      lowStockItems: (json['lowStockItems'] as List)
          .map((e) => StockItemEntity(
                name: e['name'] as String,
                currentStock: e['currentStock'] as int,
                maxStock: e['maxStock'] as int,
              ))
          .toList(),
    );
  }

  static StatEntity _statFromJson(Map<String, dynamic> json) {
    return StatEntity(
      value: (json['value'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      isPercentValue: json['isPercentValue'] as bool? ?? false,
    );
  }
}
