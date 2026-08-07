import 'package:alfasun_pos/Screens/Stock/Providers/inventory_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/get_products.dart';
// import 'package:alfasun_pos/Screens/Stock/Widgets/inventory_repository.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/inventory_repository_impl.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/search_and_filter_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inventoryRemoteDataSourceProvider = Provider<InventoryRemoteDataSource>((
  ref,
) {
  return InventoryRemoteDataSource();
});

final inventoryRepositoryProvider = Provider<InventoryRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(inventoryRemoteDataSourceProvider);
  return InventoryRepositoryImpl(remoteDataSource);
});

final getProductsProvider = Provider<GetProducts>((ref) {
  final repository = ref.watch(inventoryRepositoryProvider);
  return GetProducts(repository);
});

final searchAndFilterProductsProvider = Provider<SearchAndFilterProducts>((
  ref,
) {
  return SearchAndFilterProducts();
});
