import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


class ChangePinTile extends StatelessWidget {
  const ChangePinTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Change PIN — coming soon')),
        );
      },
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.lock_outline_rounded, size: 16, color: colors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Change PIN', style: TextStyle(color: colors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('Update your 4-digit access PIN', style: TextStyle(color: colors.textSecondary, fontSize: 11.5)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: colors.textSecondary, size: 20),
        ],
      ),
    );
  }
}
