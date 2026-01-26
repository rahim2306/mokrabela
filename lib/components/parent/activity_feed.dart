import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class RecentActivityFeed extends StatelessWidget {
  final List<dynamic>
  recentSessions; // Replace dynamic with Session model later

  const RecentActivityFeed({super.key, required this.recentSessions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            AppLocalizations.of(context)!.recentActivity,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.deepBlue,
            ),
          ),
        ),
        SizedBox(height: 1.5.h),
        if (recentSessions.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  AppLocalizations.of(context)!.noRecentActivity,
                  style: GoogleFonts.spaceGrotesk(
                    color: AppTheme.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          )
        else
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentSessions.length,
            separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
            itemBuilder: (context, index) {
              final session = recentSessions[index];
              return _buildActivityItem(session);
            },
          ),
      ],
    );
  }

  Widget _buildActivityItem(dynamic session) {
    // Determine icon and color based on type (placeholder logic)
    // Assuming session has 'type', 'duration', 'startTime', 'stressBefore', 'stressAfter'

    // Safety check if session is Map for now
    final data = session is Map ? session : <String, dynamic>{};

    final type = data['type'] ?? 'breathing';
    final startTime = (data['startTime'] is DateTime)
        ? data['startTime'] as DateTime
        : DateTime.now();
    final duration = data['duration'] ?? 0; // seconds
    final stressBefore = data['stressLevelBefore'];
    final stressAfter = data['stressLevelAfter'];

    IconData icon;
    Color color;
    String title;

    switch (type) {
      case 'focus':
        icon = Icons.games_rounded;
        color = const Color(0xFFF6D365);
        title = 'Focus Game';
        break;
      case 'story':
        icon = Icons.auto_stories_rounded;
        color = const Color(0xFFA1C4FD);
        title = 'Story Time';
        break;
      case 'drawing':
        icon = Icons.brush_rounded;
        color = const Color(0xFFF093FB);
        title = 'Creative Drawing';
        break;
      case 'breathing':
      default:
        icon = Icons.air_rounded;
        color = const Color(0xFF667EEA);
        title = 'Breathing Exercise';
    }

    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.deepBlue,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  DateFormat('MMM d, h:mm a').format(startTime),
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10.sp,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(duration / 60).ceil()} min',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepBlue,
                ),
              ),
              if (stressBefore != null && stressAfter != null) ...[
                SizedBox(height: 0.5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.5.w,
                    vertical: 0.3.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4AC29A).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 10.sp,
                        color: const Color(0xFF4AC29A),
                      ),
                      Text(
                        '${stressBefore - stressAfter}',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4AC29A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
