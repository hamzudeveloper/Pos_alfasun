import 'package:alfasun_pos/Screens/Reports/Providers/reports_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'refreshing_hint_bar.dart';
import 'staff_performance_row.dart';

class StaffPerformanceCard extends ConsumerWidget {
  const StaffPerformanceCard({super.key});

  // Cycled per row so each staff member gets a distinct, consistent color
  // for both their avatar and their progress bar.
  static List<Color> _palette(AppColorScheme colors) => [colors.primary, colors.success, colors.warning];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final reportsAsync = ref.watch(reportsProvider);
    final data = reportsAsync.valueOrNull;
    final palette = _palette(colors);

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
          Text('Staff Performance', style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          RefreshingHintBar(isRefreshing: reportsAsync.isLoading && data != null),
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
            for (int i = 0; i < data.staffPerformance.length; i++)
              StaffPerformanceRow(
                staff: data.staffPerformance[i],
                accentColor: palette[i % palette.length],
              ),
        ],
      ),
    );
  }
}
