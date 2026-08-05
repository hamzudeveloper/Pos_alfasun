import 'package:alfasun_pos/providers/theme_mode_provider.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DashboardAppBar extends ConsumerWidget {
  final String managerName;

  const DashboardAppBar({super.key, required this.managerName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.wb_sunny_rounded, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ALFASUN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: colors.textPrimary,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Good afternoon, $managerName',
              style: TextStyle(fontSize: 11, color: colors.textSecondary),
            ),
          ],
        ),
        const Spacer(),
        _CircleIconButton(
          icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          onTap: () => ref.read(themeModeProvider.notifier).toggle(),
        ),
        const SizedBox(width: 8),
        _CircleIconButton(icon: Icons.notifications_none_rounded, badgeCount: 3),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 17,
          backgroundColor: colors.primary,
          child: const Text(
            'JD',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final int? badgeCount;
  final VoidCallback? onTap;

  const _CircleIconButton({required this.icon, this.badgeCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: colors.surfaceVariant, shape: BoxShape.circle),
            child: Icon(icon, size: 17, color: colors.textPrimary),
          ),
          if (badgeCount != null && badgeCount! > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(color: colors.danger, shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
                child: Text(
                  '$badgeCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
