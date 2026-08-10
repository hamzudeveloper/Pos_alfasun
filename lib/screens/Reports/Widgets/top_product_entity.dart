/// One row in "Top Products", e.g. "#1 Nescafé 3in1, 350 sold, Rs 12,600, +18.3%".
class TopProductEntity {
  final int rank;
  final String name;
  final int unitsSold;
  final double revenue;
  final double changePercent; // positive = trending up, negative = down

  const TopProductEntity({
    required this.rank,
    required this.name,
    required this.unitsSold,
    required this.revenue,
    required this.changePercent,
  });

  bool get isPositive => changePercent >= 0;
}
