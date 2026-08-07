import 'package:flutter_riverpod/flutter_riverpod.dart';

final stockSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
 // This provider holds the current search query for stock products. It is a StateProvider that automatically disposes of its state when no longer needed. The initial value is an empty string, indicating no search query.
