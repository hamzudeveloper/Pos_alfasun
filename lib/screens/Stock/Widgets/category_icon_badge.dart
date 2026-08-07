import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

/// Maps a ProductCategory to an icon. This mapping lives here — in the
/// presentation layer — rather than on the entity itself, because "which
/// icon represents Beverages" is a UI decision, not a business rule. The
/// domain layer stays Flutter-free.
class CategoryIconBadge extends StatelessWidget {
  final ProductCategory category;

  const CategoryIconBadge({super.key, required this.category});

  IconData get _icon {
    switch (category) {
      case ProductCategory.beverages:
        return Icons.local_cafe_outlined;
      case ProductCategory.food:
        return Icons.fastfood_outlined;
      case ProductCategory.personalCare:
        return Icons.spa_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(_icon, color: colors.primary, size: 19),
    );
  }
}
