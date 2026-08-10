import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_entity.dart';


import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

import 'notification_type_icon.dart';

/// One reusable card for both tabs.
/// - Delete ("×") is always available — every notification can be removed.
/// - [onMarkAsRead] is only passed in from the Unread tab (see
///   NotificationsScreen) — when it's null, no "Mark as read" button shows.
///   That's how one widget serves both tabs without an if/else on which
///   screen it's used from.
class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onDelete;
  final VoidCallback? onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onDelete,
    this.onMarkAsRead,
  });

  String _formatTimestamp(Object? timestamp) {
    DateTime? date;
    if (timestamp is DateTime) {
      date = timestamp;
    } else if (timestamp is String) {
      date = DateTime.tryParse(timestamp);
    } else if (timestamp != null) {
      date = DateTime.tryParse(timestamp.toString());
    }

    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    }
    if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    }
    if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    }
    if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 min ago'
          : '${difference.inMinutes} mins ago';
    }

    return 'just now';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead
              ? colors.border
              : colors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationTypeIcon(type: notification.type),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!notification.isRead) ...[
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12.5,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatTimestamp(notification.timestamp),
                  style: TextStyle(color: colors.textSecondary, fontSize: 11),
                ),
                if (notification.actionLabel != null ||
                    onMarkAsRead != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (notification.actionLabel != null)
                        _SmallButton(
                          label: notification.actionLabel!,
                          filled: true,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${notification.actionLabel} — coming soon',
                                ),
                              ),
                            );
                          },
                        ),
                      if (notification.actionLabel != null &&
                          onMarkAsRead != null)
                        const SizedBox(width: 8),
                      if (onMarkAsRead != null)
                        _SmallButton(
                          label: 'Mark as read',
                          filled: false,
                          onTap: onMarkAsRead!,
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _SmallButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: filled ? colors.primary : colors.surfaceVariant,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: filled ? Colors.white : colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
