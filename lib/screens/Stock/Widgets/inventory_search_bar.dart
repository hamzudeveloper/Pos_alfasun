import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/stock_search_query_provider.dart';

/// ConsumerStatefulWidget instead of ConsumerWidget because a TextField
/// that shows a clear (X) button needs a TextEditingController — and a
/// controller needs a State object to own and dispose it.
class InventorySearchBar extends ConsumerStatefulWidget {
  const InventorySearchBar({super.key});

  @override
  ConsumerState<InventorySearchBar> createState() => _InventorySearchBarState();
}

class _InventorySearchBarState extends ConsumerState<InventorySearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Seed the field with whatever's already in the provider, in case this
    // widget rebuilds fresh (e.g. coming back to the Stock tab) while a
    // search is still active.
    _controller = TextEditingController(
      text: ref.read(stockSearchQueryProvider),
    );
    // Rebuilds just this widget when the text changes, so the clear (X)
    // button can show/hide — it does NOT touch the provider by itself.
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    print("value $value");
    print("callingiiiiiiii");
    ref.read(stockSearchQueryProvider.notifier).state = value;
  }

  void _clear() {
    _controller.clear();
    ref.read(stockSearchQueryProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    print("hsifkdfksfdkfsdk");
    final colors = context.appColors;
    final hasText = _controller.text.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        textInputAction: TextInputAction.search,
        style: TextStyle(color: colors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search products or categories...',
          hintStyle: TextStyle(color: colors.textSecondary, fontSize: 13),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: colors.textSecondary,
            size: 20,
          ),
          suffixIcon: hasText
              ? IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: colors.textSecondary,
                    size: 18,
                  ),
                  onPressed: _clear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
