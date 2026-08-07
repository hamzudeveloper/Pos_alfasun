import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'inventory_injection_provider.dart';

final productsProvider = FutureProvider.autoDispose<List<ProductEntity>>((ref) { // This provider fetches the list of products from the repository using the GetProducts use case. It is a FutureProvider that automatically disposes of its state when no longer needed. The result is a list of ProductEntity objects.
  final getProducts = ref.watch(getProductsProvider); // This line retrieves the GetProducts use case from the provider. 
  //It allows us to call the use case to fetch the list of products.
  return getProducts();
  // This provider fetches the list of products from the repository using the GetProducts use case. 
  //It is a FutureProvider that automatically disposes of its state when no longer needed. The result is a list of ProductEntity objects.
});
