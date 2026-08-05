import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


/// One card in the 2x2 stats grid. Fed a generic StatEntity + icon/label,
/// so the SAME widget renders Total Sales, Total Profit, Profit Margin, and
/// Total Orders — no copy-pasted near-identical card widgets.
class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final StatEntity stat;
  final String Function(double value) valueFormatter;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.stat,
    required this.valueFormatter,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final changeColor = stat.isPositive ? colors.success : colors.danger;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: changeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      stat.isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      size: 10,
                      color: changeColor,
                    ),
                    Text(
                      '${stat.changePercent.abs().toStringAsFixed(1)}%',
                      style: TextStyle(color: changeColor, fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            valueFormatter(stat.value),
            style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}
