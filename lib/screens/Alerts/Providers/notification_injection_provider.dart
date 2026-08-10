import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// NOT autoDispose — the data source holds our in-memory "backend" list.
/// If this got disposed every time you left the Alerts tab, your read/delete
/// changes would be forgotten each time you navigated away and back.
final notificationRemoteDataSourceProvider = Provider<NotificationRemoteDataSource>((ref) {
  return NotificationRemoteDataSource();
});

final notificationRepositoryProvider = Provider<NotificationRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(notificationRemoteDataSourceProvider);
  return NotificationRepositoryImpl(remoteDataSource);
});
