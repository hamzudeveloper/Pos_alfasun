import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_entity.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_model.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_remote_data_source.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_repository.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/sales_trend_range.dart';

/// This class fulfills the promise made by `DashboardRepository` (the
/// abstract class in domain/). It's the only place that knows a
/// `DashboardRemoteDataSource` exists — swap the data source for a real
/// API or a cached/offline one later, and only this file changes.
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  const DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<DashboardEntity> getDashboard(SalesTrendRange range) async {
    final json = await remoteDataSource.fetchDashboardJson(range);
    return DashboardModel.fromJson(json);
  }
}
