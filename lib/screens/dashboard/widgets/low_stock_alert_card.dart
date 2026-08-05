import 'package:alfasun_pos/screens/dashboard/widgets/stock_item_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

import 'stock_item_row.dart';

class LowStockAlertCard extends StatelessWidget {
  final List<StockItemEntity> items;

  const LowStockAlertCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

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
          Text(
            'Low Stock Alert',
            style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          for (final item in items) StockItemRow(item: item),
        ],
      ),
    );
  }
}
