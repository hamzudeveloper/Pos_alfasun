import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class ProductStatusPill extends StatelessWidget {
  final ProductEntity product;

  const ProductStatusPill({super.key, required this.product});

  Color _colorFor(AppColorScheme colors, StockStatus status) {
    switch (status) {
      case StockStatus.ok:
        return colors.success;
      case StockStatus.low:
        return colors.warning;
      case StockStatus.outOfStock:
        return colors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final status = product.status;
    final color = _colorFor(colors, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${status.label} ${product.currentStock}',
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
