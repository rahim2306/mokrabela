import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/parent/charts/sessions_bar_chart.dart';
import 'package:mokrabela/components/parent/charts/stress_line_chart.dart';
import 'package:mokrabela/components/parent/protocol_completion_table.dart';
import 'package:mokrabela/components/parent/time_range_selector.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/stats_models.dart';
import 'package:mokrabela/services/export_service.dart';
import 'package:mokrabela/services/stats_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class ParentStatsTab extends StatefulWidget {
  final String? selectedChildId;
  final StatsService? statsService;

  const ParentStatsTab({
    super.key,
    required this.selectedChildId,
    this.statsService,
  });

  @override
  State<ParentStatsTab> createState() => _ParentStatsTabState();
}

class _ParentStatsTabState extends State<ParentStatsTab> {
  late final StatsService _statsService;
  TimeRange _selectedRange = TimeRange.week;

  @override
  void initState() {
    super.initState();
    _statsService = widget.statsService ?? StatsService();
  }

  @override
  Widget build(BuildContext context) {
    // ... (previous code)

    final l10n = AppLocalizations.of(context)!;

    if (widget.selectedChildId == null) {
      return Center(
        child: Text(
          l10n.selectChildToView,
          style: TextStyle(fontSize: 14.sp, color: AppTheme.textSecondary),
        ),
      );
    }

    final dateRange = _getDateRange(_selectedRange);

    return FutureBuilder<
      (
        StatsData,
        List<DailySessionCount>,
        List<StressDataPoint>,
        List<WeekProgress>,
      )
    >(
      future:
          Future.wait([
            _statsService.getStats(
              widget.selectedChildId!,
              dateRange.start,
              dateRange.end,
            ),
            _statsService.getDailySessionCounts(
              widget.selectedChildId!,
              dateRange.start,
              dateRange.end,
            ),
            _statsService.getStressHistory(
              widget.selectedChildId!,
              dateRange.start,
              dateRange.end,
            ),
            _statsService.getProtocolCompletion(widget.selectedChildId!),
          ]).then(
            (results) => (
              results[0] as StatsData,
              results[1] as List<DailySessionCount>,
              results[2] as List<StressDataPoint>,
              results[3] as List<WeekProgress>,
            ),
          ),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Time Selector
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.statsAndReports,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.deepBlue,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TimeRangeSelector(
                      selected: _selectedRange,
                      onChanged: (range) {
                        setState(() {
                          _selectedRange = range;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              // Summary Stats Cards
              if (snapshot.hasData)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: _buildSummaryCards(snapshot.data!.$1, l10n),
                )
              else if (snapshot.hasError)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      Text(
                        l10n.errorLoadingStats,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        snapshot.error.toString(),
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 10.sp,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Center(child: CircularProgressIndicator()),

              SizedBox(height: 3.h),

              // Charts
              if (snapshot.hasData) ...[
                _buildChartSection(
                  l10n.activityTrends,
                  l10n.activityTrendsDesc,
                  SessionsBarChart(dailyData: snapshot.data!.$2),
                ),

                SizedBox(height: 2.h),

                _buildChartSection(
                  l10n.stressRegulation,
                  l10n.stressRegulationDesc,
                  StressLineChart(dataPoints: snapshot.data!.$3),
                ),

                SizedBox(height: 2.h),

                _buildChartSection(
                  l10n.protocolProgressTitle,
                  l10n.protocolProgressDesc,
                  ProtocolCompletionTable(weeks: snapshot.data!.$4),
                ),

                SizedBox(height: 3.h),

                _buildExportSection(
                  context,
                  snapshot.data!.$1,
                  snapshot.data!.$2,
                  snapshot.data!.$4,
                  dateRange,
                  l10n,
                ),
              ] else if (!snapshot.hasError)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: const CircularProgressIndicator(),
                ),

              SizedBox(height: 13.h), // Space for bottom nav
            ],
          ),
        );
      },
    );
  }

  Widget _buildExportSection(
    BuildContext context,
    StatsData stats,
    List<DailySessionCount> dailyStats,
    List<WeekProgress> weeks,
    ({DateTime start, DateTime end}) dateRange,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.exportReports,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 1.5.h),
          Row(
            children: [
              Expanded(
                child: _buildExportButton(
                  context,
                  l10n.pdfReport,
                  Icons.picture_as_pdf,
                  const Color(0xFFE57373),
                  () async {
                    try {
                      await ExportService().exportToPDF(
                        stats,
                        dailyStats,
                        weeks,
                        'Child Name', // TODO: Get real child name
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              l10n.errorExporting('PDF', e.toString()),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildExportButton(
                  context,
                  l10n.csvData,
                  Icons.table_chart,
                  const Color(0xFF4DB6AC),
                  () async {
                    try {
                      final sessions = await _statsService.getRawSessions(
                        widget.selectedChildId!,
                        dateRange.start,
                        dateRange.end,
                      );
                      await ExportService().exportToCSV(
                        sessions,
                        widget.selectedChildId!,
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              l10n.errorExporting('CSV', e.toString()),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 1.h),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection(String title, String subtitle, Widget chart) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18.sp, // Increased from 14.sp
              fontWeight: FontWeight.w700,
              color: AppTheme.deepBlue,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10.sp, color: AppTheme.textSecondary),
          ),
          SizedBox(height: 2.h),
          chart,
        ],
      ),
    );
  }

  Widget _buildSummaryCards(StatsData stats, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            l10n.sessions,
            stats.totalSessions.toString(),
            Icons.check_circle_outline,
            const Color(0xFF667EEA),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            l10n.calmTime,
            '${stats.totalMinutes}m',
            Icons.timer_outlined,
            const Color(0xFF8B7FEA),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            l10n.avgStressReduction,
            stats.avgStressReduction.toStringAsFixed(1),
            Icons.trending_down,
            const Color(0xFFFF9B9B),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 1.h),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24.sp, // Increased from 20.sp
              fontWeight: FontWeight.w800,
              color: AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 11.5.sp, // Increased from 10.sp
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  ({DateTime start, DateTime end}) _getDateRange(TimeRange range) {
    final now = DateTime.now();

    switch (range) {
      case TimeRange.week:
        final start = now.subtract(Duration(days: now.weekday - 1));
        return (
          start: DateTime(start.year, start.month, start.day),
          end: DateTime(now.year, now.month, now.day, 23, 59, 59),
        );

      case TimeRange.month:
        return (
          start: DateTime(now.year, now.month, 1),
          end: DateTime(now.year, now.month, now.day, 23, 59, 59),
        );

      case TimeRange.fiveWeeks:
        final start = now.subtract(const Duration(days: 35)); // 5 weeks
        return (
          start: DateTime(start.year, start.month, start.day),
          end: DateTime(now.year, now.month, now.day, 23, 59, 59),
        );
    }
  }
}
