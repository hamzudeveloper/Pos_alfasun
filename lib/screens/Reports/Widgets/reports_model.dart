

import 'package:alfasun_pos/Screens/Reports/Widgets/reports_entity.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/staff_performance_entity.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/top_product_entity.dart';

class ReportsModel extends ReportsEntity {
  const ReportsModel({
    required super.topProducts,
    required super.staffPerformance,
    required super.summary,
  });

  factory ReportsModel.fromJson(Map<String, dynamic> json) {
    return ReportsModel(
      topProducts: (json['topProducts'] as List)
          .map((e) => TopProductEntity(
                rank: e['rank'] as int,
                name: e['name'] as String,
                unitsSold: e['unitsSold'] as int,
                revenue: (e['revenue'] as num).toDouble(),
                changePercent: (e['changePercent'] as num).toDouble(),
              ))
          .toList(),
      staffPerformance: (json['staffPerformance'] as List)
          .map((e) => StaffPerformanceEntity(
                name: e['name'] as String,
                role: e['role'] as String,
                revenue: (e['revenue'] as num).toDouble(),
                transactionCount: e['transactionCount'] as int,
                targetProgress: (e['targetProgress'] as num).toDouble(),
              ))
          .toList(),
      summary: SummaryStatsEntity(
        totalRevenue: (json['summary']['totalRevenue'] as num).toDouble(),
        avgOrder: (json['summary']['avgOrder'] as num).toDouble(),
        returnRatePercent: (json['summary']['returnRatePercent'] as num).toDouble(),
      ),
    );
  }
}
