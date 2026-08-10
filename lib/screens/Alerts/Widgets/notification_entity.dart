import 'notification_type.dart';

/// One notification. isRead is part of the data, not separate — so "which
/// notifications are unread" is always just `notifications.where((n) => !n.isRead)`,
/// never something that can drift out of sync.
class NotificationEntity {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? actionLabel; // e.g. "View Report", "Record Payment" — null if no action

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    this.actionLabel,
  });

  NotificationEntity copyWith({bool? isRead}) {
    return NotificationEntity(
      id: id,
      type: type,
      title: title,
      message: message,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
      actionLabel: actionLabel,
    );
  }
}
