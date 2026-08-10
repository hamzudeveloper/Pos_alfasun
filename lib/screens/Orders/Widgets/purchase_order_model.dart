

import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_order_entity.dart';

class PurchaseOrderModel extends PurchaseOrderEntity {
  const PurchaseOrderModel({
    required super.id,
    required super.poNumber,
    required super.vendorName,
    required super.orderDate,
    required super.itemsDescription,
    required super.totalAmount,
    required super.amountPaid,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderModel(
      id: json['id'] as String,
      poNumber: json['poNumber'] as String,
      vendorName: json['vendorName'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      itemsDescription: json['itemsDescription'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      amountPaid: (json['amountPaid'] as num).toDouble(),
    );
  }
}
