import 'package:alfasun_pos/Screens/Orders/Providers/purchases_provider.dart';
import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_filter.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseFilterChips extends ConsumerWidget {
  const PurchaseFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final selected = ref.watch(purchaseFilterProvider);

    return Row(
      children: PurchaseFilter.values.map((filter) {
        final isSelected = filter == selected;
        final flex = filter.label.isEmpty ? 1 : filter.label.length;
        return Expanded(
          flex: flex,
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              onTap: () =>
                  ref.read(purchaseFilterProvider.notifier).state = filter,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : colors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  filter.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : colors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
