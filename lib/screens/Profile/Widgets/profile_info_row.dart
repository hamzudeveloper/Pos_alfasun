import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoRow({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 16, color: colors.primary),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: TextStyle(color: colors.textSecondary, fontSize: 10, letterSpacing: 0.5)),
            const SizedBox(height: 2),
            Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
