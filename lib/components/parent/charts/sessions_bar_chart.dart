import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mokrabela/models/stats_models.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class SessionsBarChart extends StatefulWidget {
  final List<DailySessionCount> dailyData;

  const SessionsBarChart({super.key, required this.dailyData});

  @override
  State<SessionsBarChart> createState() => _SessionsBarChartState();
}

class _SessionsBarChartState extends State<SessionsBarChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.dailyData.isEmpty) {
      return Center(
        child: Text(
          'No data for this period',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => Colors.blueGrey,
              tooltipHorizontalAlignment: FLHorizontalAlignment.center,
              tooltipMargin: -10,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final dayData = widget.dailyData[group.x.toInt()];
                return BarTooltipItem(
                  '${DateFormat('MMM d').format(dayData.date)}\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${rod.toY.toInt()} sessions',
                      style: const TextStyle(
                        color: Colors.white, // widget.touchedBarColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '\n${dayData.totalMinutes} mins',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
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
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < widget.dailyData.length) {
                    final date = widget.dailyData[index].date;
                    // Show short day name for week view, date for month view
                    final isSmallList = widget.dailyData.length <= 7;
                    final text = isSmallList
                        ? DateFormat('E').format(date) // Mon, Tue
                        : (index % 5 == 0
                              ? DateFormat('d').format(date)
                              : ''); // 1, 6, 11 (sparse labels)

                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4,
                      child: Text(
                        text,
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value == value.toInt().toDouble()) {
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
          barGroups: widget.dailyData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final isTouched = index == touchedIndex;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data.count.toDouble(),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  width: widget.dailyData.length > 7 ? 8 : 16,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: _getMaxY(),
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                ),
              ],
              showingTooltipIndicators: isTouched ? [0] : [],
            );
          }).toList(),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withValues(alpha: 0.1),
                strokeWidth: 1,
              );
            },
          ),
        ),
      ),
    );
  }

  double _getMaxY() {
    double max = 0;
    for (var item in widget.dailyData) {
      if (item.count > max) max = item.count.toDouble();
    }
    return (max < 5) ? 5 : max + 1; // Minimum height of 5
  }
}
