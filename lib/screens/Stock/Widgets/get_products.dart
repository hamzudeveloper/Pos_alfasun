
import 'package:alfasun_pos/Screens/Stock/Widgets/inventory_repository.dart';
import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';

class GetProducts {
  // This class represents the use case for fetching products from the inventory repository. It encapsulates the logic for retrieving a list of ProductEntity objects from the repository.
  final InventoryRepository repository;
  // The repository is an instance of InventoryRepository that is used to fetch product data. It allows the GetProducts use case to interact with the underlying data source, whether it's a remote API or a local database.

  const GetProducts(this.repository);
  // The constructor takes an InventoryRepository as a parameter and initializes the repository field. This allows the GetProducts use case to use the provided repository for fetching product data.

  Future<List<ProductEntity>> call() => repository.getProducts();
  // The call method is defined to invoke the getProducts method of the repository. It returns a Future that resolves to a list of ProductEntity objects, representing the products fetched from the inventory.
  // This method allows the GetProducts use case to be called like a function, making it convenient to use in the application code.
}
