import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/stats_models.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class ProtocolCompletionTable extends StatelessWidget {
  final List<WeekProgress> weeks;

  const ProtocolCompletionTable({super.key, required this.weeks});

  @override
  Widget build(BuildContext context) {
    if (weeks.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noProtocolData,
          style: TextStyle(color: AppTheme.textSecondary),
        ),
      );
    }

    return Column(
      children: weeks.map((week) => _buildWeekRow(context, week)).toList(),
    );
  }

  Widget _buildWeekRow(BuildContext context, WeekProgress week) {
    final titles = [
      AppLocalizations.of(context)!.weekTitleRegulationSafety,
      AppLocalizations.of(context)!.weekTitleFocusControl,
      AppLocalizations.of(context)!.weekTitleDailyStructure,
      AppLocalizations.of(context)!.weekTitleCreativeCalm,
      AppLocalizations.of(context)!.weekTitleIntegrationReview,
    ];

    final title = (week.weekIndex <= titles.length)
        ? titles[week.weekIndex - 1]
        : 'Week ${week.weekIndex}';

    // Simplify title for table (remove & newlines)
    final cleanTitle = title.replaceAll('\n', ' ');

    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Week circle
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getStatusColor(
                week.progressPercent,
              ).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${week.weekIndex}',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: _getStatusColor(week.progressPercent),
                ),
              ),
            ),
          ),
          SizedBox(width: 3.w),

          // Title & Progress Bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cleanTitle,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: AppTheme.deepBlue,
                      ),
                    ),
                    Text(
                      '${week.progressPercent.toInt()}%',
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: _getStatusColor(week.progressPercent),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.8.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: week.progressPercent / 100,
                    backgroundColor: Colors.grey.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getStatusColor(week.progressPercent),
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(double percent) {
    if (percent >= 100) return const Color(0xFF4CAF50); // Green
    if (percent > 0) return const Color(0xFF667EEA); // Blue
    return Colors.grey.shade400; // Grey
  }
}
