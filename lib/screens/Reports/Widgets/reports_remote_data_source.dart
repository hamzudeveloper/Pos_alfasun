
import 'package:alfasun_pos/Screens/Reports/Widgets/report_range.dart';

/// Stands in for a real API call — swap the body of [fetchReportsJson] for
/// a real network call later, nothing else needs to change.
class ReportsRemoteDataSource {
  Future<Map<String, dynamic>> fetchReportsJson(ReportRange range) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // A real backend would just return different numbers for different
    // ranges. Here we scale the "week" figures up/down to fake that.
    final scale = switch (range) {
      ReportRange.today => 0.18,
      ReportRange.week => 1.0,
      ReportRange.month => 4.3,
    };

    return {
      'topProducts': [
        {'rank': 1, 'name': 'Nescafé 3in1', 'unitsSold': (350 * scale).round(), 'revenue': 12600.0 * scale, 'changePercent': 18.3},
        {'rank': 2, 'name': 'Milo Activ-Go', 'unitsSold': (195 * scale).round(), 'revenue': 13260.0 * scale, 'changePercent': 9.1},
        {'rank': 3, 'name': 'Lucky Me Pancit', 'unitsSold': (220 * scale).round(), 'revenue': 3300.0 * scale, 'changePercent': 6.5},
        {'rank': 4, 'name': 'C2 Apple Tea', 'unitsSold': (380 * scale).round(), 'revenue': 3960.0 * scale, 'changePercent': -2.3},
        {'rank': 5, 'name': 'Piattos Cheese', 'unitsSold': (160 * scale).round(), 'revenue': 4785.0 * scale, 'changePercent': 11.7},
        {'rank': 6, 'name': 'Colgate Total', 'unitsSold': (140 * scale).round(), 'revenue': 6720.0 * scale, 'changePercent': 3.2},
      ],
      'staffPerformance': [
        {'name': 'Maria Santos', 'role': 'Cashier', 'revenue': 32400.0 * scale, 'transactionCount': (245 * scale).round(), 'targetProgress': 0.81},
        {'name': 'Juan Reyes', 'role': 'Cashier', 'revenue': 28750.0 * scale, 'transactionCount': (198 * scale).round(), 'targetProgress': 0.82},
        {'name': 'Ana Cruz', 'role': 'Sr. Cashier', 'revenue': 41800.0 * scale, 'transactionCount': (312 * scale).round(), 'targetProgress': 0.93},
        {'name': 'Pedro Lim', 'role': 'Cashier', 'revenue': 22300.0 * scale, 'transactionCount': (167 * scale).round(), 'targetProgress': 0.74},
      ],
      'summary': {
        'totalRevenue': 58620.0 * scale,
        'avgOrder': 204.0,
        'returnRatePercent': 2.3,
      },
    };
  }
}
