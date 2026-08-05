import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard_injection_provider.dart';
import 'sales_trend_range_provider.dart';

/// FutureProvider is the right tool here (instead of StateNotifier) because
/// all we're doing is "fetch async data and expose loading/error/success" —
/// FutureProvider gives you that for free as an AsyncValue<DashboardEntity>.
///
/// Because this provider does `ref.watch(salesTrendRangeProvider)`, Riverpod
/// automatically re-runs this whole function — and refetches — whenever the
/// user taps Today/Week/Month. You never manually call "refresh" yourself.
///
/// In the UI:
///   final dashboardAsync = ref.watch(dashboardProvider);
///   dashboardAsync.when(
///     data: (dashboard) => ...,
///     loading: () => ...,
///     error: (e, st) => ...,
///   );
final dashboardProvider = FutureProvider.autoDispose<DashboardEntity>((ref) {
  final range = ref.watch(salesTrendRangeProvider);
  final getDashboardData = ref.watch(getDashboardDataProvider);
  return getDashboardData(range);
});
