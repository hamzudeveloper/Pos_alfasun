import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_filter.dart';
import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_order_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'purchase_injection_provider.dart';

/// Fetches the full list once.
final purchaseOrdersProvider =
    FutureProvider.autoDispose<List<PurchaseOrderEntity>>((ref) {
      final repository = ref.watch(purchaseRepositoryProvider);
      return repository.getPurchaseOrders();
    });

/// Holds which tab (All/Due/Partial/Paid) is selected.
final purchaseFilterProvider = StateProvider.autoDispose<PurchaseFilter>(
  (ref) => PurchaseFilter.all,
);

/// Combines the two above. Filtering here is a one-line `where`, so it
/// doesn't earn its own use-case class — that would just be ceremony
/// around a single boolean check.
final filteredPurchaseOrdersProvider =
    Provider.autoDispose<AsyncValue<List<PurchaseOrderEntity>>>((ref) {
      final ordersAsync = ref.watch(purchaseOrdersProvider);
      final filter = ref.watch(purchaseFilterProvider);

      return ordersAsync.whenData((orders) {
        if (filter == PurchaseFilter.all)  return orders;
        return orders
            .where((order) => order.status.name == filter.name)
            .toList();
      });
    });
