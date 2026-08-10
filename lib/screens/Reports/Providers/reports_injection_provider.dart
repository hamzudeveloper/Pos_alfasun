import 'package:alfasun_pos/Screens/Reports/Widgets/reports_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Reports/Widgets/reports_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final reportsRemoteDataSourceProvider = Provider<ReportsRemoteDataSource>((ref) {
  return ReportsRemoteDataSource();
});

final reportsRepositoryProvider = Provider<ReportsRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(reportsRemoteDataSourceProvider);
  return ReportsRepositoryImpl(remoteDataSource);
});
