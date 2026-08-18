import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


class NotificationsEmptyState extends StatelessWidget {
  final bool isUnreadTab;

  const NotificationsEmptyState({super.key, required this.isUnreadTab});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(
              isUnreadTab ? Icons.done_all_rounded : Icons.notifications_none_rounded,
              size: 32,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isUnreadTab ? "You're all caught up!" : 'No notifications yet',
            style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            isUnreadTab ? 'Nothing new to read right now.' : "We'll let you know when something arrives.",
            style: TextStyle(color: colors.textSecondary, fontSize: 12.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
