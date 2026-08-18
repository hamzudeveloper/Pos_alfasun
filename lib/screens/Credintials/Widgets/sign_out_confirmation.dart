import 'package:alfasun_pos/Screens/StoreCode/Presentation/store_code_screen.dart';
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
    // TODO (API day): call the real sign-out endpoint / clear the stored
    // session token here before navigating away.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const StoreCodeScreen(loginData: null)),
      (route) =>
          false, // clears the whole stack — no way back into the app via the back button
    );
  }
}
