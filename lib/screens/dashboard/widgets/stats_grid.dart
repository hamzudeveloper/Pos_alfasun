import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

import 'stat_card.dart';

class StatsGrid extends StatelessWidget {
  final DashboardEntity dashboard;

  const StatsGrid({super.key, required this.dashboard});

  String _rupees(double value) {
    // Simple thousands separator, e.g. 86240 -> "86,240"
    final rounded = value.round().toString();
    final buffer =
        StringBuffer(); // Use StringBuffer for efficient string concatenation
    for (int i = 0; i < rounded.length; i++) {
      // Loop through each character in the rounded string
      final posFromEnd = rounded.length - i;
      // Add the current digit to the buffer
      buffer.write(rounded[i]); // Write the current character to the buffer
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    // Add a comma after every 3 digits, except for the last group
    return '$buffer';
  }

  String _plainNumber(double value) {
    return _rupees(value).replaceFirst('Rs ', '');
  }

  String _percent(double value) => '${value.toStringAsFixed(1)}%';

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        StatCard(
          icon: Icons.attach_money_rounded,
          iconColor: colors.primary,
          label: 'Total Sales',
          stat: dashboard.totalSales,
          valueFormatter: _rupees,
        ),
        StatCard(
          icon: Icons.trending_up_rounded,
          iconColor: colors.success,
          label: 'Total Profit',
          stat: dashboard.totalProfit,
          valueFormatter: _rupees,
        ),
        StatCard(
          icon: Icons.percent_rounded,
          iconColor: colors.warning,
          label: 'Profit Margin',
          stat: dashboard.profitMargin,
          valueFormatter: _percent,
        ),
        StatCard(
          icon: Icons.shopping_bag_outlined,
          iconColor: colors.primary,
          label: 'Total Orders',
          stat: dashboard.totalOrders,
          valueFormatter: _plainNumber,
        ),
      ],
    );
  }
}
