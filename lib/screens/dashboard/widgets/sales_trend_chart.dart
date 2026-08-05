import 'package:alfasun_pos/screens/dashboard/widgets/sales_point_entity.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// The actual chart rendering. Kept separate from SalesTrendCard so this
/// widget's only job is "draw these points" — it doesn't know about the
/// Today/Week/Month toggle or any provider at all.
class SalesTrendChart extends StatelessWidget {
  final List<SalesPointEntity> points;

  const SalesTrendChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    if (points.isEmpty) return const SizedBox(height: 180);

    final maxY = points.map((p) => p.value).reduce((a, b) => a > b ? a : b) * 1.15;

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (value) => FlLine(
              color: colors.border,
              strokeWidth: 1,
              dashArray: [4, 4],
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) => Text(
                  '${(value / 1000).toStringAsFixed(0)}k',
                  style: TextStyle(color: colors.textSecondary, fontSize: 10),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= points.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      points[index].label,
                      style: TextStyle(color: colors.textSecondary, fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => colors.surface,
              tooltipBorder: BorderSide(color: colors.border),
              getTooltipItems: (spots) => spots.map((spot) {
                final point = points[spot.x.toInt()];
                return LineTooltipItem(
                  '${point.label}  Rs ${point.value.toStringAsFixed(0)}',
                  TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].value),
              ],
              isCurved: true,
              color: colors.chartLine,
              barWidth: 2.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                  radius: 3.5,
                  color: colors.chartLine,
                  strokeWidth: 2,
                  strokeColor: colors.surface,
                ),
              ),
              belowBarData: BarAreaData(show: true, color: colors.chartFill),
            ),
          ],
        ),
      ),
    );
  }
}
