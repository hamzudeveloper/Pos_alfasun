import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/sales_trend_range.dart';

/// Holds which toggle (Today/Week/Month) is currently selected.
/// dashboardProvider watches this — see dashboard_provider.dart — so
/// changing it automatically refetches the chart data for the new range.
final salesTrendRangeProvider = StateProvider<SalesTrendRange>((ref) {
  return SalesTrendRange.week; // matches the design's default selected tab
});
