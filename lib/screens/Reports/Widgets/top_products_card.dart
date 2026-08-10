import 'package:alfasun_pos/Screens/Reports/Providers/reports_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'refreshing_hint_bar.dart';
import 'top_product_row.dart';

/// This card watches reportsProvider ITSELF, independently of the screen
/// around it. That's what makes range-switching cheap: ReportsScreen never
/// watches reportsProvider, so it never rebuilds — only this card (and the
/// other two data cards) do, because they're the only widgets actually
/// subscribed to that data.
class TopProductsCard extends ConsumerWidget {
  const TopProductsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final reportsAsync = ref.watch(reportsProvider);

    // Prefer showing the last known data even while a new fetch is in
    // flight (see the comment on reportsProvider) — only fall back to a
    // full spinner if there's truly nothing to show yet.
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Products', style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          RefreshingHintBar(isRefreshing: reportsAsync.isLoading && data != null),
          if (data == null)
            reportsAsync.when(
              data: (_) => const SizedBox.shrink(), // handled above via `data`
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
            for (final product in data.topProducts) TopProductRow(product: product),
        ],
      ),
    );
  }
}
