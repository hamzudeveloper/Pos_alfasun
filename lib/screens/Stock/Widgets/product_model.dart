

import 'package:alfasun_pos/Screens/Stock/Widgets/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.category,
    required super.currentStock,
    required super.lowStockThreshold,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: ProductCategory.values.byName(json['category'] as String),
      currentStock: json['currentStock'] as int,
      lowStockThreshold: json['lowStockThreshold'] as int,
    );
  }
}
