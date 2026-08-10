

import 'package:alfasun_pos/Screens/Reports/Widgets/report_range.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/reports_entity.dart';

abstract class ReportsRepository {
  Future<ReportsEntity> getReports(ReportRange range);
}
