

import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_entity.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/sales_trend_range.dart';

/// This is an interface (abstract class), not an implementation.
/// The domain layer only knows "something can give me a DashboardEntity
/// for a given range" — it doesn't care if that something is a REST API,
/// a local database, or mock data. That's the Dependency Inversion
/// Principle (the "D" in SOLID): high-level code (use cases) depends on
/// this abstraction, and low-level code (the data layer) implements it.
abstract class DashboardRepository {
  Future<DashboardEntity> getDashboard(SalesTrendRange range);
}
