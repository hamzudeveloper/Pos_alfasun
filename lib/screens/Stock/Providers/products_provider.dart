import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'inventory_injection_provider.dart';

final productsProvider = FutureProvider<List<ProductEntity>>((ref) { // This provider fetches the list of products from the repository using the GetProducts use case. It is a FutureProvider that automatically disposes of its state when no longer needed. The result is a list of ProductEntity objects.
  final repository = ref.watch(inventoryRepositoryProvider); // This line retrieves the InventoryRepository from the provider. It allows us to access the repository's methods to fetch data.
  return repository.getProducts(); // This line calls the getProducts method of the InventoryRepository to fetch the list of products. The result is returned as a Future<List<ProductEntity>>.

  // This provider fetches the list of products from the repository using the GetProducts use case. 
  //It is a FutureProvider that automatically disposes of its state when no longer needed. The result is a list of ProductEntity objects.
});
