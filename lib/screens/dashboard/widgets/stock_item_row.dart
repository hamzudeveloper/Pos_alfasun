import 'package:alfasun_pos/screens/dashboard/widgets/stock_item_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class StockItemRow extends StatelessWidget {
  final StockItemEntity item;

  const StockItemRow({super.key, required this.item});

  Color _severityColor(AppColorScheme colors) {
    switch (item.severity) {
      case StockSeverity.critical:
        return colors.danger;
      case StockSeverity.low:
        return colors.warning;
      case StockSeverity.warning:
        return colors.warning.withOpacity(0.7);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final barColor = _severityColor(colors);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name, style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
              Text(
                '${item.currentStock}/${item.maxStock}',
                style: TextStyle(color: barColor, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: item.ratio.clamp(0, 1),
              minHeight: 6,
              backgroundColor: colors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
        ],
      ),
    );
  }
}
