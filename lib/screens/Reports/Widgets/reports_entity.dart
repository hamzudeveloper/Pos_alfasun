import 'staff_performance_entity.dart';
import 'top_product_entity.dart';

class SummaryStatsEntity {
  final double totalRevenue;
  final double avgOrder;
  final double returnRatePercent;

  const SummaryStatsEntity({
    required this.totalRevenue,
    required this.avgOrder,
    required this.returnRatePercent,
  });
}

/// Everything the Reports screen needs for one selected range (Today/Week/Month).
/// Fetched in a single call, same shape as DashboardEntity in the dashboard feature.
class ReportsEntity {
  final List<TopProductEntity> topProducts;
  final List<StaffPerformanceEntity> staffPerformance;
  final SummaryStatsEntity summary;

  const ReportsEntity({
    required this.topProducts,
    required this.staffPerformance,
    required this.summary,
  });
}
