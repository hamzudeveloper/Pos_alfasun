import 'package:alfasun_pos/Common/dashboard_app_bar.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import '../widgets/report_range_toggle.dart';
import '../widgets/staff_performance_card.dart';
import '../widgets/summary_stats_card.dart';
import '../widgets/top_products_card.dart';

/// Deliberately a plain StatelessWidget, NOT a ConsumerWidget. It never
/// calls ref.watch on anything data-related — it only lays out child
/// widgets. Each child (ReportRangeToggle, TopProductsCard,
/// StaffPerformanceCard, SummaryStatsCard) is its own ConsumerWidget that
/// watches exactly what it needs.
///
/// Result: switching Today/Week/Month never rebuilds THIS widget. Flutter
/// only rebuilds the handful of small widgets actually subscribed to the
/// providers that changed — the screen's structure (this ListView, its
/// padding, the app bar) stays untouched the entire time.
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const DashboardAppBar(managerName: 'Hamzu'),
        const SizedBox(height: 20),
        Text(
          'Reports',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        const ReportRangeToggle(),
        const SizedBox(height: 16),
        const TopProductsCard(),
        const SizedBox(height: 16),
        const StaffPerformanceCard(),
        const SizedBox(height: 16),
        const SummaryStatsCard(),
      ],
    );
  }
}
