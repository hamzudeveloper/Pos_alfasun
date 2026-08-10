

import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_order_entity.dart';
import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_order_model.dart';
import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_remote_data_source.dart';
import 'package:alfasun_pos/Screens/Orders/Widgets/purchase_repository.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseRemoteDataSource remoteDataSource;

  const PurchaseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PurchaseOrderEntity>> getPurchaseOrders() async {
    final jsonList = await remoteDataSource.fetchPurchaseOrdersJson();
    return jsonList.map(PurchaseOrderModel.fromJson).toList();
  }
}
