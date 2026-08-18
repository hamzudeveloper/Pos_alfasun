import 'package:alfasun_pos/Screens/Profile/Widgets/user_profile_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class ProfileAvatarHeader extends StatelessWidget {
  final UserProfileEntity user;
  final bool compact;
  final bool showEmail;

  const ProfileAvatarHeader({
    super.key,
    required this.user,
    this.compact = false,
    this.showEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final avatarRadius = compact ? 18.0 : 32.0;

    return Row(
      crossAxisAlignment: compact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundColor: colors.success,
          child: Text(
            user.initials,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: compact ? 13 : 20),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName,
                style: TextStyle(color: colors.textPrimary, fontSize: compact ? 13.5 : 17, fontWeight: FontWeight.bold),
              ),
              if (showEmail) ...[
                const SizedBox(height: 2),
                Text(user.email, style: TextStyle(color: colors.textSecondary, fontSize: 12.5)),
              ],
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  user.role,
                  style: TextStyle(color: colors.primary, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
