import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/dashboard_provider.dart';
import 'app_bottom_nav_bar.dart';
import 'dashboard_app_bar.dart';
import 'low_stock_alert_card.dart';
import 'low_stock_notice_bar.dart';
import 'manager_banner_card.dart';
import 'quick_actions_card.dart';
import 'sales_trend_card.dart';
import 'stats_grid.dart';

class ManagerDashboardScreen extends ConsumerStatefulWidget {
  const ManagerDashboardScreen({super.key});

  @override
  ConsumerState<ManagerDashboardScreen> createState() =>
      _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState
    extends ConsumerState<ManagerDashboardScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    // Watching dashboardProvider gives us an AsyncValue<DashboardEntity>.
    // Because dashboardProvider watches salesTrendRangeProvider internally,
    // this whole screen automatically rebuilds with fresh data whenever the
    // user taps Today/Week/Month — no manual refresh call needed anywhere.
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: colors.background,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index, ),
      ),
      body: SafeArea(
        child: dashboardAsync.when(
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
                  onViewTap: () =>
                      setState(() => _navIndex = 1), // jump to Stock tab
                ),
                const SizedBox(height: 16),
                StatsGrid(dashboard: dashboard),
                // const SizedBox(height: 16),
                // SalesTrendCard(points: dashboard.salesTrend),
                // const SizedBox(height: 16),
                // LowStockAlertCard(items: dashboard.lowStockItems),
                // const SizedBox(height: 16),
                // const QuickActionsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
