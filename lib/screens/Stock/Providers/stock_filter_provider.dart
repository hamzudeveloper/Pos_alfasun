import 'package:alfasun_pos/Screens/Stock/Widgets/stock_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../domain/entities/stock_filter.dart';

final stockFilterProvider = StateProvider<StockFilter>((ref) => StockFilter.all); 
// This provider holds the current stock filter state. It is a StateProvider that automatically disposes of its state when no longer needed. The initial value is StockFilter.all, indicating that all products are shown by default.
