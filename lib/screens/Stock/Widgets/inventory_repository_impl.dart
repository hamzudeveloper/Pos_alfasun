

import 'package:alfasun_pos/Screens/Stock/Providers/inventory_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/inventory_repository.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/product_model.dart';

class InventoryRepositoryImpl implements InventoryRepository { // This class implements the InventoryRepository interface and provides the actual implementation for fetching products from a remote data source.
  final InventoryRemoteDataSource remoteDataSource;
  // The remoteDataSource is an instance of InventoryRemoteDataSource that is used to fetch product data from a remote source, such as an API.
  const InventoryRepositoryImpl(this.remoteDataSource);
  // The constructor takes an InventoryRemoteDataSource as a parameter and initializes the remoteDataSource field. This allows the repository to use the remote data source for fetching product data.

  @override
  Future<List<ProductEntity>> getProducts() async { // This method overrides the getProducts method from the InventoryRepository interface. It is responsible for fetching the list of products from the remote data source and returning them as a list of ProductEntity objects.
    final jsonList = await remoteDataSource.fetchProductsJson(); // This line calls the fetchProductsJson method of the remoteDataSource to retrieve the product data in JSON format. The result is stored in the jsonList variable.
    return jsonList.map<ProductEntity>((json) => ProductModel.fromJson(json)).toList(); // This line maps each JSON object in the jsonList to a ProductModel instance using the fromJson factory constructor. The resulting list of ProductModel objects is then converted to a list of ProductEntity objects and returned.
  }
}
