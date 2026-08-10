import 'package:alfasun_pos/Screens/Alerts/Providers/notification_derived_providers.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notifications_controller.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkAllReadButton extends ConsumerWidget {
  const MarkAllReadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    // Watching the count (not the raw list) means this only rebuilds when
    // the number actually changes from >0 to 0 or back — not on every
    // unrelated notification update.
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final hasUnread = unreadCount > 0;

    return TextButton(
      onPressed: hasUnread ? () => ref.read(notificationsControllerProvider.notifier).markAllAsRead() : null,
      child: Text(
        'Mark all read',
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: hasUnread ? colors.primary : colors.textSecondary.withOpacity(0.5),
        ),
      ),
    );
  }
}
