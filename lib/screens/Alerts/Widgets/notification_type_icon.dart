import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_type.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class NotificationTypeIcon extends StatelessWidget {
  final NotificationType type;

  const NotificationTypeIcon({super.key, required this.type});

  (IconData, Color) _iconAndColor(AppColorScheme colors) {
    switch (type) {
      case NotificationType.endOfDayReport:
        return (Icons.assessment_outlined, colors.primary);
      case NotificationType.lowStock:
        return (Icons.warning_amber_rounded, colors.warning);
      case NotificationType.paymentDue:
        return (Icons.calendar_today_outlined, colors.primary);
      case NotificationType.systemBackup:
        return (Icons.cloud_done_outlined, colors.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final (icon, color) = _iconAndColor(colors);

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(11)),
      child: Icon(icon, color: color, size: 18),
    );
  }
}
