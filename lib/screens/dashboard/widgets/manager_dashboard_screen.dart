import 'package:alfasun_pos/providers/dashboard_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/low_stock_alert_card.dart';
import '../widgets/low_stock_notice_bar.dart';
import '../widgets/manager_banner_card.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/sales_trend_card.dart';
import '../widgets/stats_grid.dart';

/// IMPORTANT: this is now just the Home TAB's CONTENT — no Scaffold, no
/// bottom nav bar. Those live one level up, in MainShellScreen, which is
/// what actually owns tab-switching. This widget only knows how to render
/// the dashboard; it has no idea it's sitting inside a tab bar at all.
///
/// [onViewLowStock] lets the parent (the shell) decide what happens when
/// the user taps "View" on the low-stock banner — e.g. switch to the Stock
/// tab — without this widget needing to know about tab indices itself.
class ManagerDashboardScreen extends ConsumerWidget {
  final VoidCallback? onViewLowStock;

  const ManagerDashboardScreen({super.key, this.onViewLowStock});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final dashboardAsync = ref.watch(dashboardProvider);

    return dashboardAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Could not load dashboard.\n$error',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.textSecondary),
          ),
        ),
      ),
      data: (dashboard) => RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardProvider.future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            DashboardAppBar(managerName: dashboard.managerName),
            const SizedBox(height: 16),
            ManagerBannerCard(
              managerName: dashboard.managerName,
              lastSyncedAt: dashboard.lastSyncedAt,
              isOnline: dashboard.isOnline,
            ),
            const SizedBox(height: 14),
            LowStockNoticeBar(
              itemCount: dashboard.lowStockItems.length,
              onViewTap: onViewLowStock,
            ),
            const SizedBox(height: 16),
            StatsGrid(dashboard: dashboard),
            const SizedBox(height: 16),
            SalesTrendCard(points: dashboard.salesTrend),
            const SizedBox(height: 16),
            LowStockAlertCard(items: dashboard.lowStockItems),
            const SizedBox(height: 16),
            const QuickActionsCard(),
          ],
        ),
      ),
    );
  }
}