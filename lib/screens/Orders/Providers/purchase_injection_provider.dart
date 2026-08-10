import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Orders/Providers/purchase_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchaseRemoteDataSourceProvider = Provider<PurchaseRemoteDataSource>((
  ref,
) {
  return PurchaseRemoteDataSource();
});

final purchaseRepositoryProvider = Provider<PurchaseRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(purchaseRemoteDataSourceProvider);
  return PurchaseRepositoryImpl(remoteDataSource);
});
