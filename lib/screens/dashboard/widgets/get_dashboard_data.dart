import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_entity.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_repository.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/sales_trend_range.dart';


/// A use case does exactly ONE thing — here, fetch dashboard data.
/// It's a thin wrapper around the repository, but as the app grows this is
/// where you'd add business rules that don't belong in the UI or the data
/// layer (e.g. "don't show a stat if it's still syncing").
///
/// The `call()` method lets you invoke this class like a function:
///   final getDashboardData = GetDashboardData(repository);
///   final data = await getDashboardData(SalesTrendRange.week);
class GetDashboardData {
  final DashboardRepository repository;

  const GetDashboardData(this.repository);

  Future<DashboardEntity> call(SalesTrendRange range) {
    return repository.getDashboard(range);
  }
}
