import 'package:alfasun_pos/Screens/Reports/Providers/reports_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'refreshing_hint_bar.dart';

class SummaryStatsCard extends ConsumerWidget {
  const SummaryStatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final reportsAsync = ref.watch(reportsProvider);
    final data = reportsAsync.valueOrNull;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary Stats', style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          RefreshingHintBar(isRefreshing: reportsAsync.isLoading && data != null),
          const SizedBox(height: 8),
          if (data == null)
            reportsAsync.when(
              data: (_) => const SizedBox.shrink(),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('Could not load.\n$error', style: TextStyle(color: colors.textSecondary)),
              ),
            )
          else
            Row(
              children: [
                _StatChip(label: 'Total Revenue', value: 'Rs ${data.summary.totalRevenue.toStringAsFixed(0)}', color: colors.primary),
                const SizedBox(width: 10),
                _StatChip(label: 'Avg Order', value: 'Rs ${data.summary.avgOrder.toStringAsFixed(0)}', color: colors.success),
                const SizedBox(width: 10),
                _StatChip(label: 'Return Rate', value: '${data.summary.returnRatePercent.toStringAsFixed(1)}%', color: colors.warning),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
