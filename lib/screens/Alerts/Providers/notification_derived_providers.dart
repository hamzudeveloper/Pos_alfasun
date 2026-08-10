import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_entity.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_filter.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notifications_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// The single source of truth for "how many unread notifications are there".
/// This is what the bottom nav badge, the top app bar bell badge, the red
/// "4" next to the Notifications title, AND the "Unread (4)" tab label all
/// read from. Because they all watch the SAME provider, they can never
/// disagree with each other or drift out of sync — mark one notification
/// as read, and every one of those badges updates in the same frame.
final unreadNotificationCountProvider = Provider.autoDispose<int>((ref) {
  final notifications = ref.watch(notificationsControllerProvider).valueOrNull ?? [];
  return notifications.where((n) => !n.isRead).length;
});

/// Which tab (All / Unread) is selected.
final notificationFilterProvider = StateProvider.autoDispose<NotificationFilter>((ref) {
  return NotificationFilter.all;
});

/// The list actually shown, after applying the selected tab's filter.
final filteredNotificationsProvider = Provider.autoDispose<AsyncValue<List<NotificationEntity>>>((ref) {
  final notificationsAsync = ref.watch(notificationsControllerProvider);
  final filter = ref.watch(notificationFilterProvider);

  return notificationsAsync.whenData((notifications) {
    if (filter == NotificationFilter.all) return notifications;
    return notifications.where((n) => !n.isRead).toList();
  });
});
