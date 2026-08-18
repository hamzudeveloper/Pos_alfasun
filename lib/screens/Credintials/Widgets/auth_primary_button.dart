import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


class AuthPrimaryButton extends StatelessWidget {
  final String label;
  final IconData? trailingIcon;
  final bool enabled;
  final VoidCallback onPressed;

  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.onPressed,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          disabledBackgroundColor: colors.surfaceVariant,
          foregroundColor: Colors.white,
          disabledForegroundColor: colors.textSecondary,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}
