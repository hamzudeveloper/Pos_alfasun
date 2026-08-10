import 'package:alfasun_pos/Screens/Reports/Widgets/top_product_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


class TopProductRow extends StatelessWidget {
  final TopProductEntity product;

  const TopProductRow({super.key, required this.product});

  static const _rankColors = [Color(0xFFF5A623), Color(0xFFB0B0B0), Color(0xFFCD7F32)]; // gold/silver/bronze

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final changeColor = product.isPositive ? colors.success : colors.danger;
    final rankColor = product.rank <= 3 ? _rankColors[product.rank - 1] : colors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: rankColor.withValues(alpha: 0.15),
            child: Text(
              '${product.rank}',
              style: TextStyle(color: rankColor, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                Text('${product.unitsSold} sold', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rs ${product.revenue.toStringAsFixed(0)}',
                style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Icon(
                    product.isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                    size: 11,
                    color: changeColor,
                  ),
                  Text(
                    '${product.changePercent.abs().toStringAsFixed(1)}%',
                    style: TextStyle(color: changeColor, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
