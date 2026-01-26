import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mokrabela/models/stats_models.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class StressLineChart extends StatefulWidget {
  final List<StressDataPoint> dataPoints;

  const StressLineChart({super.key, required this.dataPoints});

  @override
  State<StressLineChart> createState() => _StressLineChartState();
}

class _StressLineChartState extends State<StressLineChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataPoints.isEmpty) {
      return Center(
        child: Text(
          'No stress data available',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
      );
    }

    // Sort points by time just in case
    final points = List<StressDataPoint>.from(widget.dataPoints)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withValues(alpha: 0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: (points.length / 5)
                    .ceilToDouble(), // Dynamic interval
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < points.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4,
                      child: Text(
                        DateFormat('M/d').format(points[index].timestamp),
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 2,
                reservedSize: 30,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value >= 0 && value <= 10) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4,
                      child: Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 11.sp,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (points.length - 1).toDouble(),
          minY: 0,
          maxY: 10,
          lineBarsData: [
            // Before Stress Line (Red/Orange)
            LineChartBarData(
              spots: points.asMap().entries.map((e) {
                return FlSpot(
                  e.key.toDouble(),
                  e.value.beforeStress.toDouble(),
                );
              }).toList(),
              isCurved: true,
              color: const Color(0xFFFF9B9B),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            // After Stress Line (Purple/Green)
            LineChartBarData(
              spots: points.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value.afterStress.toDouble());
              }).toList(),
              isCurved: true,
              color: const Color(0xFF8B7FEA),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF8B7FEA).withValues(alpha: 0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => Colors.blueGrey,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final flSpot = barSpot;
                  final isBefore = barSpot.barIndex == 0;

                  return LineTooltipItem(
                    '${isBefore ? "Before" : "After"}: ${flSpot.y.toInt()}',
                    TextStyle(
                      color: isBefore
                          ? const Color(0xFFFF9B9B)
                          : const Color(0xFF8B7FEA),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
