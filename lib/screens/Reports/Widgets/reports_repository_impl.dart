import 'package:alfasun_pos/Screens/Reports/Widgets/report_range.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/reports_entity.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/reports_repository.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/reports_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/reports_model.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource remoteDataSource;

  const ReportsRepositoryImpl(this.remoteDataSource);

  @override
  Future<ReportsEntity> getReports(ReportRange range) async {
    final json = await remoteDataSource.fetchReportsJson(range);
    return ReportsModel.fromJson(json);
  }
}
