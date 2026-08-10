
import 'package:alfasun_pos/Common/app_bottom_nav_bar.dart';
import 'package:alfasun_pos/Screens/Alerts/Presentation/notifications_screen.dart';
import 'package:alfasun_pos/Screens/Orders/Presentation/purchases_screen.dart';
import 'package:alfasun_pos/Screens/Reports/Presentation/reports_screen.dart';
import 'package:alfasun_pos/Screens/Stock/Presentation/inventory_screen.dart';

import 'package:alfasun_pos/Screens/Dashboard/widgets/manager_dashboard_screen.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This is the ONE place in the app that owns "which tab is active" and the
/// bottom nav bar. Every tab screen (ManagerDashboardScreen, and later real
/// Stock/Orders/Reports/Alerts screens) is just content — it has no idea a
/// tab bar exists. That's what makes tapping a nav icon actually work: this
/// widget swaps *which screen sits under* the shared Scaffold/nav bar.
///
/// IndexedStack (not a simple `if` swap) keeps every tab's widget tree alive
/// in memory even when it's not visible — so scrolling position, provider
/// state, etc. on the Home tab isn't lost when you go check Stock and come back.
class MainShellScreen extends ConsumerStatefulWidget {
  const MainShellScreen({super.key});

  @override
  ConsumerState<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends ConsumerState<MainShellScreen> {
  int _navIndex = 0;

  void _goToTab(int index) => setState(() => _navIndex = index);

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final tabs = [
      ManagerDashboardScreen(onViewLowStock: () => _goToTab(1)), // Home -> jumps to Stock
      const InventoryScreen(),
      const PurchasesScreen(),
      const ReportsScreen(),
      const NotificationsScreen(),
    ];

    return Scaffold(
      backgroundColor: colors.background,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: _goToTab,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _navIndex,
          children: tabs,
        ),
      ),
    );
  }
}