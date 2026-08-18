import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

import 'sign_out_confirmation.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => confirmSignOut(context),
        icon: Icon(Icons.logout_rounded, size: 18, color: colors.danger),
        label: Text('Sign Out', style: TextStyle(color: colors.danger, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.danger.withValues(alpha: 0.08),
          side: BorderSide(color: colors.danger.withValues(alpha: 0.25)),
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
