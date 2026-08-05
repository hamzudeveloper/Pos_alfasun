/// Tiny date helper — avoids pulling in the `intl` package for one format.
class DateFormatter {
  DateFormatter._();

  static const _weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];
  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  /// e.g. "Tuesday, August 4, 2026"
  static String full(DateTime date) {
    final weekday = _weekdays[date.weekday - 1];
    final month = _months[date.month - 1];
    return '$weekday, $month ${date.day}, ${date.year}';
  }

  /// e.g. "04:33 PM"
  static String time(DateTime date) {
    final hour24 = date.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final period = hour24 >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    final hour = hour12.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  /// e.g. "Good morning" / "Good afternoon" / "Good evening"
  static String greeting(DateTime date) {
    if (date.hour < 12) return 'Good morning';
    if (date.hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}
