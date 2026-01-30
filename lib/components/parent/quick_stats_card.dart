import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/common/animated_number.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class QuickStatsCard extends StatefulWidget {
  final int totalSessions;
  final int totalMinutes;
  final int streakDays;

  const QuickStatsCard({
    super.key,
    required this.totalSessions,
    required this.totalMinutes,
    required this.streakDays,
  });

  @override
  State<QuickStatsCard> createState() => _QuickStatsCardState();
}

class _QuickStatsCardState extends State<QuickStatsCard> {
  late int _displayedSessions;
  late int _displayedMinutes;
  late int _displayedStreak;

  @override
  void initState() {
    super.initState();
    _displayedSessions = widget.totalSessions;
    _displayedMinutes = widget.totalMinutes;
    _displayedStreak = widget.streakDays;
  }

  @override
  void didUpdateWidget(QuickStatsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update displayed values when props change
    if (oldWidget.totalSessions != widget.totalSessions ||
        oldWidget.totalMinutes != widget.totalMinutes ||
        oldWidget.streakDays != widget.streakDays) {
      setState(() {
        _displayedSessions = widget.totalSessions;
        _displayedMinutes = widget.totalMinutes;
        _displayedStreak = widget.streakDays;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.thisWeek,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.deepBlue,
                ),
              ),
              Icon(
                Icons.calendar_today_rounded,
                size: 16.sp,
                color: AppTheme.textSecondary,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                label: AppLocalizations.of(context)!.sessions,
                value: '$_displayedSessions',
                icon: Icons.check_circle_outline_rounded,
                color: const Color(0xFF667EEA),
              ),
              Container(
                width: 1,
                height: 5.h,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              _buildStatItem(
                label: AppLocalizations.of(context)!.calmTime,
                value: '${_displayedMinutes}m',
                icon: Icons.timer_outlined,
                color: const Color(0xFF8B7FEA), // Warm purple instead of teal
              ),
              Container(
                width: 1,
                height: 5.h,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              _buildStatItem(
                label: AppLocalizations.of(context)!.streak,
                value: '$_displayedStreak',
                icon: Icons.local_fire_department_rounded,
                color: const Color(0xFFFF9B9B),
                isStreak: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    bool isStreak = false,
  }) {
    // Extract number and suffix
    final numericValue =
        int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final suffix = value.replaceAll(RegExp(r'[0-9]'), '');

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedNumber(
              value: numericValue,
              suffix: suffix.isNotEmpty ? suffix : null,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.deepBlue,
                height: 1.0,
              ),
            ),
            if (isStreak)
              Padding(
                padding: EdgeInsets.only(left: 1.w, bottom: 0.5.h),
                child: Icon(icon, color: color, size: 14.sp),
              ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 13.sp,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
