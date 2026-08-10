/// One row in "Staff Performance", e.g. "Maria Santos, Cashier, Rs 32,400, 245 txns, 81% of target".
class StaffPerformanceEntity {
  final String name;
  final String role;
  final double revenue;
  final int transactionCount;
  final double targetProgress; // 0.0 - 1.0

  const StaffPerformanceEntity({
    required this.name,
    required this.role,
    required this.revenue,
    required this.transactionCount,
    required this.targetProgress,
  });

  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();
}
