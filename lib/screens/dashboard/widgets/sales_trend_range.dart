enum SalesTrendRange {
  today,
  week,
  month;

  String get label {
    switch (this) {
      case SalesTrendRange.today:
        return 'Today';
      case SalesTrendRange.week:
        return 'Week';
      case SalesTrendRange.month:
        return 'Month';
    }
  }
}
