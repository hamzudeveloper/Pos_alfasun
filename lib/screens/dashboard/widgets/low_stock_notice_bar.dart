import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class LowStockNoticeBar extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onViewTap;

  const LowStockNoticeBar({super.key, required this.itemCount, this.onViewTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    if (itemCount <= 0) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: colors.warning, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$itemCount items low in stock',
              style: TextStyle(
                color: colors.warning,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onViewTap,
            child: Row(
              children: [
                Text(
                  'View',
                  style: TextStyle(
                    color: colors.warning,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: colors.warning,
                  size: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
