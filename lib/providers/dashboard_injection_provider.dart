import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_remote_data_source.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/dashboard_repository_impl.dart';
import 'package:alfasun_pos/screens/dashboard/widgets/get_dashboard_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// This file is the "composition root" for the dashboard feature — the one
/// place that knows about every layer at once (data, domain, presentation)
/// and wires them together. Everywhere else in the app only ever asks for
/// getDashboardDataProvider and gets a fully-built use case back.

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  return DashboardRemoteDataSource();
});

/// Notice the return type here is the CONCRETE DashboardRepositoryImpl.
/// This provider exposes the implementation directly so the returned value
/// matches the provider signature.
final dashboardRepositoryProvider = Provider<DashboardRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(dashboardRemoteDataSourceProvider);
  return DashboardRepositoryImpl(remoteDataSource);
});

final getDashboardDataProvider = Provider<GetDashboardData>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetDashboardData(repository);
});
