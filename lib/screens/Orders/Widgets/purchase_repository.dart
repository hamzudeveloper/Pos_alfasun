import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_order_entity.dart';


abstract class PurchaseRepository {
  Future<List<PurchaseOrderEntity>> getPurchaseOrders();
}
