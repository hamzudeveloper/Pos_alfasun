import 'package:alfasun_pos/Screens/Alerts/Providers/notification_injection_provider.dart';
import 'package:alfasun_pos/Screens/Alerts/Widgets/notification_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Unlike the read-only FutureProviders elsewhere in this app, notifications
/// need to be MUTATED (marked read, deleted) — that's exactly what
// / StateNotifier is for. State here is AsyncValue<List<NotificationEntity>>
/// so we still get clean loading/error/data handling for the initial fetch,
/// while every mutation method updates `state` directly and instantly.
class NotificationsController extends StateNotifier<AsyncValue<List<NotificationEntity>>> {
  final dynamic _repository;

  NotificationsController(this._repository) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final notifications = await _repository.getNotifications();
      state = AsyncValue.data(notifications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Optimistic update: change `state` immediately so the UI reacts right
  /// away, THEN tell the repository. If you were hitting a real API and it
  /// failed, you'd want to roll this back — kept simple here since it's mocked.
  Future<void> markAsRead(String id) async {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncValue.data([
      for (final n in current) if (n.id == id) n.copyWith(isRead: true) else n,
    ]);

    await _repository.markAsRead(id);
  }

  Future<void> markAllAsRead() async {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncValue.data([for (final n in current) n.copyWith(isRead: true)]);

    await _repository.markAllAsRead();
  }

  Future<void> delete(String id) async {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncValue.data([for (final n in current) if (n.id != id) n]);

    await _repository.deleteNotification(id);
  }
}

final notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, AsyncValue<List<NotificationEntity>>>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationsController(repository);
});
