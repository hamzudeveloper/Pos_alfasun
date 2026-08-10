/// Stands in for a real backend. It keeps its own in-memory list — every
/// method mutates THAT list and returns a copy, same as a real API would
/// persist changes and return fresh data. Swap this whole class for a real
/// HTTP client later; nothing above it (repository, controller) needs to change.
class NotificationRemoteDataSource {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 'n1',
      'type': 'endOfDayReport',
      'title': 'End of Day Report Ready',
      'message': 'The daily sales report for Main Branch is ready to view.',
      'timestamp': DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
      'isRead': false,
      'actionLabel': 'View Report',
    },
    {
      'id': 'n2',
      'type': 'lowStock',
      'title': 'Low Stock Warning',
      'message': 'Milo Activ-Go is at 15 units. Consider restocking soon.',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
      'isRead': false,
      'actionLabel': null,
    },
    {
      'id': 'n3',
      'type': 'paymentDue',
      'title': 'Payment Due Tomorrow',
      'message': 'PO-2024-001 from SM Trading Corp — Rs 12,400 payment due Jan 11.',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      'isRead': false,
      'actionLabel': 'Record Payment',
    },
    {
      'id': 'n4',
      'type': 'systemBackup',
      'title': 'System Backup Complete',
      'message': 'Daily data backup completed successfully at 2:00 AM.',
      'timestamp': DateTime.now().subtract(const Duration(days: 1, hours: 2)).toIso8601String(),
      'isRead': false,
      'actionLabel': null,
    },
  ];

  Future<List<Map<String, dynamic>>> fetchNotificationsJson() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.of(_notifications); // copy — callers shouldn't mutate our internal list directly
  }

  Future<void> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _notifications.indexWhere((n) => n['id'] == id);
    if (index != -1) _notifications[index]['isRead'] = true;
  }

  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 150));
    for (final n in _notifications) {
      n['isRead'] = true;
    }
  }

  Future<void> deleteNotification(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _notifications.removeWhere((n) => n['id'] == id);
  }
}
