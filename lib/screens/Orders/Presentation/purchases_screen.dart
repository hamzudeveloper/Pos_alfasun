import 'package:alfasun_pos/Common/dashboard_app_bar.dart';
import 'package:alfasun_pos/Screens/Orders/Providers/purchases_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/outstanding_payables_banner.dart';
import '../widgets/purchase_filter_chips.dart';
import '../widgets/purchase_order_card.dart';

class PurchasesScreen extends ConsumerWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final ordersAsync = ref.watch(purchaseOrdersProvider); // raw list, for the banner total
    final filteredAsync = ref.watch(filteredPurchaseOrdersProvider); // filtered list, for the rows below

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const DashboardAppBar(managerName: 'Hamzu'),
        const SizedBox(height: 20),
        Text(
          'Purchases',
          style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        ordersAsync.when(
          loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
          error: (error, stackTrace) => Text('Could not load purchases.\n$error', style: TextStyle(color: colors.textSecondary)),
          data: (orders) => OutstandingPayablesBanner(orders: orders),
        ),
        const SizedBox(height: 16),
        const PurchaseFilterChips(),
        const SizedBox(height: 14),
        filteredAsync.when(
          loading: () => const SizedBox.shrink(), // banner's spinner already shown above
          error: (error, stackTrace) => const SizedBox.shrink(),
          data: (orders) {
            if (orders.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Center(
                  child: Text('No orders in this filter.', style: TextStyle(color: colors.textSecondary)),
                ),
              );
            }
            return Column(
              children: [for (final order in orders) PurchaseOrderCard(order: order)],
            );
          },
        ),
      ],
    );
  }
}
