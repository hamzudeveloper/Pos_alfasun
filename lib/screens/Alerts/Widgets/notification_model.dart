

import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_entity.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_type.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.type,
    required super.title,
    required super.message,
    required super.timestamp,
    required super.isRead,
    super.actionLabel,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      type: NotificationType.values.byName(json['type'] as String),
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool,
      actionLabel: json['actionLabel'] as String?,
    );
  }
}
