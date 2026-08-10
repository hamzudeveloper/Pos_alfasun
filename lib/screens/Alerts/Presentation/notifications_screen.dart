import 'package:alfasun_pos/Common/dashboard_app_bar.dart';
import 'package:alfasun_pos/Screens/Alerts/Providers/notification_derived_providers.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_filter.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_filter_tabs.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notifications_controller.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notifications_empty_state.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/mark_all_read_button.dart';
import '../widgets/notification_card.dart';


class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final filter = ref.watch(notificationFilterProvider);
    final filteredAsync = ref.watch(filteredNotificationsProvider);
    final controller = ref.read(notificationsControllerProvider.notifier);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const DashboardAppBar(managerName: 'Hamzu'),
        const SizedBox(height: 20),
        Row(
          children: [
            Text('Notifications', style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: colors.danger, borderRadius: BorderRadius.circular(10)),
                child: Text('$unreadCount', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
            const Spacer(),
            const MarkAllReadButton(),
          ],
        ),
        const SizedBox(height: 14),
        const NotificationFilterTabs(),
        const SizedBox(height: 14),
        filteredAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(child: Text('Could not load notifications.\n$error', style: TextStyle(color: colors.textSecondary))),
          ),
          data: (notifications) {
            if (notifications.isEmpty) {
              return NotificationsEmptyState(isUnreadTab: filter == NotificationFilter.unread);
            }
            return Column(
              children: [
                for (final notification in notifications)
                  NotificationCard(
                    notification: notification,
                    onDelete: () => controller.delete(notification.id),
                    // Only the Unread tab offers an explicit "Mark as read"
                    // button — on the All tab, read state is just shown via
                    // the little dot, not an action to take.
                    onMarkAsRead:
                        filter == NotificationFilter.unread ? () => controller.markAsRead(notification.id) : null,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
