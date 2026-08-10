import 'package:alfasun_pos/Common/dashboard_app_bar.dart';
import 'package:alfasun_pos/Screens/Stock/Providers/filtered_products_provider.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/inventory_search_bar.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/product_list_item.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/stock_filter_chips.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Same shape as ManagerDashboardScreen: just content, no Scaffold/nav bar —
/// MainShellScreen provides those. This is what plugs into the Stock tab.
class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final filteredAsync = ref.watch(filteredProductsProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const DashboardAppBar(managerName: 'Hamzu'),
        const SizedBox(height: 20),
        Text(
          'Inventory',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        const InventorySearchBar(),
        const SizedBox(height: 14),
        const StockFilterChips(),
        const SizedBox(height: 14),
        filteredAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Could not load inventory.\n$error',
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.textSecondary),
              ),
            ),
          ),
          data: (products) => Column(
           
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${products.length} products',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              if (products.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Center(
                    child: Text(
                      'No products match your search.',
                      style: TextStyle(color: colors.textSecondary),
                    ),
                  ),
                )
              else
                for (final product in products)
                  ProductListItem(product: product),
            ],
          ),
        ),
      ],
    );
  }
}
