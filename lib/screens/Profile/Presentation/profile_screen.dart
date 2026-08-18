import 'package:alfasun_pos/Screens/Profile/provider/user_profile_provider.dart';
import 'package:alfasun_pos/providers/theme_mode_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/change_pin_tile.dart';
import '../widgets/preference_toggle_row.dart';
import '../widgets/profile_avatar_header.dart';
import '../widgets/profile_info_row.dart';
import '../widgets/sign_out_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final user = ref.watch(currentUserProvider);
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final notificationsEnabled = ref.watch(notificationsPreferenceProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: colors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('My Profile', style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.border),
            ),
            child: ProfileAvatarHeader(user: user, showEmail: true),
          ),
          const SizedBox(height: 20),

          _SectionLabel('ACCOUNT'),
          const SizedBox(height: 8),
          _SectionCard(
            children: [
              ProfileInfoRow(icon: Icons.person_outline, label: 'Full Name', value: user.fullName),
              const SizedBox(height: 16),
              ProfileInfoRow(icon: Icons.badge_outlined, label: 'Email / ID', value: user.email),
            ],
          ),
          const SizedBox(height: 20),

          _SectionLabel('SECURITY'),
          const SizedBox(height: 8),
          const _SectionCard(children: [ChangePinTile()]),
          const SizedBox(height: 20),

          _SectionLabel('PREFERENCES'),
          const SizedBox(height: 8),
          _SectionCard(
            children: [
              PreferenceToggleRow(
                icon: Icons.light_mode_outlined,
                title: 'Light Mode',
                subtitle: 'Toggle app appearance',
                value: !isDark,
                onChanged: (_) => ref.read(themeModeProvider.notifier).toggle(),
              ),
              const SizedBox(height: 16),
              PreferenceToggleRow(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle: 'Stock alerts & system updates',
                value: notificationsEnabled,
                onChanged: (value) => ref.read(notificationsPreferenceProvider.notifier).state = value,
              ),
            ],
          ),
          const SizedBox(height: 24),

          const SignOutButton(),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Text(text, style: TextStyle(color: colors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5));
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(children: children),
    );
  }
}
