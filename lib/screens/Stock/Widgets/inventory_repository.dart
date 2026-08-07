import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';



abstract class InventoryRepository {
  // This abstract class defines the contract for an inventory repository. It declares a method for fetching products, which must be implemented by any concrete class that implements this interface.
  Future<List<ProductEntity>> getProducts();
  // The getProducts method is an abstract method that returns a Future resolving to a list of ProductEntity objects.
  // Any class that implements this interface must provide an implementation for this method, which is responsible for fetching the list of products from the underlying data source, whether it's a remote API or a local database. The method is asynchronous, allowing for non-blocking operations when fetching data.
}
