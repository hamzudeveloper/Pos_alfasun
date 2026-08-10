

import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_entity.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_model.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  const NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final jsonList = await remoteDataSource.fetchNotificationsJson();
    return jsonList.map(NotificationModel.fromJson).toList();
  }

  @override
  Future<void> markAsRead(String id) => remoteDataSource.markAsRead(id);

  @override
  Future<void> markAllAsRead() => remoteDataSource.markAllAsRead();

  @override
  Future<void> deleteNotification(String id) => remoteDataSource.deleteNotification(id);
}
