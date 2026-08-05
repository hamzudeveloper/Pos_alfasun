import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

import 'quick_action_button.dart';

class QuickActionsCard extends StatelessWidget {
  final VoidCallback? onNewSale;
  final VoidCallback? onPurchase;
  final VoidCallback? onAddProduct;
  final VoidCallback? onReports;

  const QuickActionsCard({
    super.key,
    this.onNewSale,
    this.onPurchase,
    this.onAddProduct,
    this.onReports,
  });

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
            'Quick Actions',
            style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              QuickActionButton(
                icon: Icons.shopping_cart_outlined,
                iconColor: colors.primary,
                label: 'New Sale',
                onTap: onNewSale,
              ),
              QuickActionButton(
                icon: Icons.inventory_2_outlined,
                iconColor: colors.success,
                label: 'Purchase',
                onTap: onPurchase,
              ),
              QuickActionButton(
                icon: Icons.add_box_outlined,
                iconColor: colors.warning,
                label: 'Add Product',
                onTap: onAddProduct,
              ),
              QuickActionButton(
                icon: Icons.bar_chart_rounded,
                iconColor: colors.primary,
                label: 'Reports',
                onTap: onReports,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
