enum ReportRange {
  today,
  week,
  month;

  String get label {
    switch (this) {
      case ReportRange.today:
        return 'Today';
      case ReportRange.week:
        return 'This Week';
      case ReportRange.month:
        return 'This Month';
    }
  }
}
