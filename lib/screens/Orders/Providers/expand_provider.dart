import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchaseOrderExpandedProvider = StateProvider.autoDispose
    .family<bool, String>((ref, poNumber) => false);