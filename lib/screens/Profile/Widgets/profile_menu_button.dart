import 'package:alfasun_pos/Screens/Profile/Presentation/profile_screen.dart';
import 'package:alfasun_pos/Screens/Profile/provider/user_profile_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_avatar_header.dart';
import 'sign_out_confirmation.dart';

enum _ProfileMenuAction { myProfile, signOut }

/// Wraps the avatar circle. Tapping it opens a PopupMenuButton — Flutter's
/// built-in dropdown-anchored-to-a-widget mechanism, which is exactly what
/// the design calls for (a card popping up right under the avatar).
class ProfileMenuButton extends ConsumerWidget {
  const ProfileMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final user = ref.watch(currentUserProvider);

    return PopupMenuButton<_ProfileMenuAction>(
      color: colors.surface,
      offset: const Offset(0, 46),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (action) {
        switch (action) {
          case _ProfileMenuAction.myProfile:
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          case _ProfileMenuAction.signOut:
            confirmSignOut(context);
        }
      },
      itemBuilder: (context) => [
        // Header row — not selectable, just information.
        PopupMenuItem<_ProfileMenuAction>(
          enabled: false,
          child: ProfileAvatarHeader(user: user, compact: true),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<_ProfileMenuAction>(
          value: _ProfileMenuAction.myProfile,
          child: Row(
            children: [
              Icon(Icons.person_outline, size: 18, color: colors.textSecondary),
              const SizedBox(width: 10),
              Text(
                'My Profile',
                style: TextStyle(color: colors.textPrimary, fontSize: 13.5),
              ),
            ],
          ),
        ),
        PopupMenuItem<_ProfileMenuAction>(
          value: _ProfileMenuAction.signOut,
          child: Row(
            children: [
              Icon(Icons.logout_rounded, size: 18, color: colors.danger),
              const SizedBox(width: 10),
              Text(
                'Sign Out',
                style: TextStyle(
                  color: colors.danger,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
      child: CircleAvatar(
        radius: 17,
        backgroundColor: colors.success,
        child: Text(
          user.initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
