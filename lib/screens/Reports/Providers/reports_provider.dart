import 'package:alfasun_pos/Screens/Reports/Widgets/report_range.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/reports_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reports_injection_provider.dart';

/// Which toggle (Today/This Week/This Month) is selected.
final reportRangeProvider = StateProvider.autoDispose<ReportRange>((ref) => ReportRange.week);

/// Fetches report data for whichever range is currently selected.
///
/// IMPORTANT for why switching ranges feels smooth instead of flashing a
/// blank spinner: Riverpod's FutureProvider automatically keeps the LAST
/// successful value available (via AsyncValue.valueOrNull) while a new
/// fetch triggered by a dependency change (reportRangeProvider here) is
/// still in flight — it marks the state as "refreshing" rather than wiping
/// it back to a fresh loading state. The cards below read `valueOrNull`
/// first and only fall back to a spinner if there's truly no data yet
/// (e.g. the very first load).
final reportsProvider = FutureProvider.autoDispose<ReportsEntity>((ref) {
  final range = ref.watch(reportRangeProvider);
  final repository = ref.watch(reportsRepositoryProvider);
  return repository.getReports(range);
});
