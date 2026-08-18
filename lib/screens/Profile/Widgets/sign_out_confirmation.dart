import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

/// One shared confirmation flow so the profile popup and the Profile
/// screen's Sign Out button behave identically instead of each rolling
/// their own dialog.
Future<void> confirmSignOut(BuildContext context) async {
  final colors = context.appColors;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: colors.surface,
      title: Text('Sign out?', style: TextStyle(color: colors.textPrimary)),
      content: Text(
        'You\'ll need to sign in again to access the dashboard.',
        style: TextStyle(color: colors.textSecondary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text('Cancel', style: TextStyle(color: colors.textSecondary)),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(
            'Sign Out',
            style: TextStyle(color: colors.danger, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );

  if (confirmed == true && context.mounted) {
    Navigator.pop(context);
    // TODO: hook up to real auth once a login flow exists — for now this
    // just confirms the action happened.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Signed out')));
  }
}
