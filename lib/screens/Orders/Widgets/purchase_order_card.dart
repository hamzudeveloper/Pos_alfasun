import 'package:alfasun_pos/Screens/Orders/Providers/expand_provider.dart';
import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_order_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'record_payment_button.dart';

/// Expand/collapse state is tracked by Riverpod so the card can rebuild from
/// provider state instead of local `setState()`.
class PurchaseOrderCard extends ConsumerWidget {
  final PurchaseOrderEntity order;

  const PurchaseOrderCard({super.key, required this.order});

  Color _statusColor(AppColorScheme colors, PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.due:
        return colors.danger;
      case PurchaseStatus.partial:
        return colors.warning;
      case PurchaseStatus.paid:
        return colors.success;
    }
  }

  String _formattedDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final order = this.order;
    final statusColor = _statusColor(colors, order.status);
    final expanded = ref.watch(purchaseOrderExpandedProvider(order.poNumber));

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: InkWell(
        onTap: () =>
            ref
                    .read(
                      purchaseOrderExpandedProvider(order.poNumber).notifier,
                    )
                    .state =
                !expanded,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Header row (always visible) ----------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              order.vendorName,
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              order.status.label,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${order.poNumber} · ${_formattedDate(order.orderDate)}',
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Rs ${order.totalAmount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedRotation(
                  turns: expanded
                      ? 0.5
                      : 0, // rotates 180 degrees when expanded
                  duration: const Duration(milliseconds: 150),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colors.textSecondary,
                    size: 20,
                  ),
                ),
              ],
            ),

            // ---------- Expanded details ----------
            if (expanded) ...[
              const SizedBox(height: 12),
              Divider(color: colors.border, height: 1),
              const SizedBox(height: 12),
              Text(
                order.itemsDescription,
                style: TextStyle(color: colors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 10),
              _AmountRow(
                label: 'Total Amount',
                value: order.totalAmount,
                valueColor: colors.textPrimary,
              ),
              const SizedBox(height: 6),
              _AmountRow(
                label: 'Amount Paid',
                value: order.amountPaid,
                valueColor: colors.success,
              ),
              const SizedBox(height: 6),
              _AmountRow(
                label: 'Remaining',
                value: order.remaining,
                valueColor: order.remaining > 0
                    ? colors.danger
                    : colors.success,
              ),

              // Progress bar only makes sense mid-payment.
              if (order.status == PurchaseStatus.partial) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: order.percentPaid,
                    minHeight: 6,
                    backgroundColor: colors.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation(colors.warning),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(order.percentPaid * 100).toStringAsFixed(0)}% paid',
                  style: TextStyle(color: colors.textSecondary, fontSize: 11),
                ),
              ],

              // No point recording a payment on something already fully paid.
              if (order.status != PurchaseStatus.paid) ...[
                const SizedBox(height: 12),
                RecordPaymentButton(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Record payment for ${order.poNumber} — coming soon',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final double value;
  final Color valueColor;

  const _AmountRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: colors.textSecondary, fontSize: 12),
        ),
        Text(
          'Rs ${value.toStringAsFixed(0)}',
          style: TextStyle(
            color: valueColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
