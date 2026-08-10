import 'package:alfasun_pos/Screens/Reports/Widgets/staff_performance_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


class StaffPerformanceRow extends StatelessWidget {
  final StaffPerformanceEntity staff;
  final Color accentColor;

  const StaffPerformanceRow({super.key, required this.staff, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: accentColor,
                child: Text(
                  staff.initial,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(staff.name, style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                    Text(staff.role, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rs ${staff.revenue.toStringAsFixed(0)}',
                    style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  Text('${staff.transactionCount} txns', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Sales Target', style: TextStyle(color: colors.textSecondary, fontSize: 10)),
              const Spacer(),
              Text(
                '${(staff.targetProgress * 100).toStringAsFixed(0)}%',
                style: TextStyle(color: accentColor, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: staff.targetProgress.clamp(0, 1),
              minHeight: 6,
              backgroundColor: colors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
