import 'package:alfasun_pos/Screens/Alerts/Providers/notification_derived_providers.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_filter.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NotificationFilterTabs extends ConsumerWidget {
  const NotificationFilterTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final selected = ref.watch(notificationFilterProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: colors.surfaceVariant, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'All',
              isSelected: selected == NotificationFilter.all,
              onTap: () => ref.read(notificationFilterProvider.notifier).state = NotificationFilter.all,
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'Unread ($unreadCount)',
              isSelected: selected == NotificationFilter.unread,
              onTap: () => ref.read(notificationFilterProvider.notifier).state = NotificationFilter.unread,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? colors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? colors.textPrimary : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
