import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_order_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


class OutstandingPayablesBanner extends StatelessWidget {
  final List<PurchaseOrderEntity> orders;

  const OutstandingPayablesBanner({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    // "Outstanding" = what's actually still owed on anything not fully paid.
    final pending = orders.where((o) => o.status != PurchaseStatus.paid);
    final total = pending.fold<double>(0, (sum, o) => sum + o.remaining);
    final count = pending.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.primary.withValues(alpha: 0.75)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUTSTANDING PAYABLES',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Rs ${total.toStringAsFixed(0)}',
            style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Across $count pending orders',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
