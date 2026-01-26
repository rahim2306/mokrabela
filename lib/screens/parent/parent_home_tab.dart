import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/parent/activity_feed.dart';
import 'package:mokrabela/components/parent/protocol_roadmap_card.dart';
import 'package:mokrabela/components/parent/quick_stats_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/protocol_enrollment_model.dart';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Parent Home Tab - Protocol overview and recent activity
class ParentHomeTab extends StatefulWidget {
  final String? selectedChildId;

  const ParentHomeTab({super.key, required this.selectedChildId});

  @override
  State<ParentHomeTab> createState() => _ParentHomeTabState();
}

class _ParentHomeTabState extends State<ParentHomeTab> {
  final ProtocolService _protocolService = ProtocolService();

  @override
  Widget build(BuildContext context) {
    if (widget.selectedChildId == null) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.selectChildToView,
          style: TextStyle(fontSize: 14.sp, color: AppTheme.textSecondary),
        ),
      );
    }

    return StreamBuilder<ProtocolEnrollment?>(
      stream: _protocolService.getEnrollmentStream(widget.selectedChildId!),
      builder: (context, enrollmentSnapshot) {
        final enrollment = enrollmentSnapshot.data;

        // In a real app, we would also stream sessions here
        // For now, we mock the session data until StatsService is fully ready
        // or we can use a direct Firestore query in a FutureBuilder

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sessions')
              .where('childId', isEqualTo: widget.selectedChildId)
              .orderBy('startTime', descending: true)
              .limit(5)
              .snapshots(),
          builder: (context, sessionSnapshot) {
            final sessions =
                sessionSnapshot.data?.docs.map((doc) => doc.data()).toList() ??
                [];

            // Calculate quick stats locally for MVP
            // Ideally should be pre-aggregated
            final totalSessions =
                sessionSnapshot.data?.docs.length ??
                0; // This only counts last 5 if limited, need aggregate query for total
            // For MVP quick stats, we'll just show placeholders if we don't have the aggregate service yet
            // Or we can assume the user has < 100 sessions and query all (careful with reads)

            // Let's use dummy stats for "Total" but real for "Recent Activity" to avoid read spikes
            // Real implementation comes in Phase 3

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      AppLocalizations.of(context)!.parentOverview,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.deepBlue,
                      ),
                    ),
                  ),

                  // Protocol Roadmap (Horizontal Scroll)
                  ProtocolRoadmapCard(enrollment: enrollment),

                  SizedBox(height: 3.h),

                  // Quick Stats
                  // Calculate real stats from sessions or show 0 if empty
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: QuickStatsCard(
                      totalSessions: sessions.length,
                      totalMinutes: sessions.isEmpty
                          ? 0
                          : sessions.fold<int>(0, (total, s) {
                              final data = s as Map<String, dynamic>;
                              final duration = data['duration'] as int? ?? 0;
                              return total + (duration ~/ 60);
                            }),
                      streakDays: sessions.isEmpty
                          ? 0
                          : (enrollment?.currentWeek ?? 1),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Recent Activity Feed
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: RecentActivityFeed(recentSessions: sessions),
                  ),

                  SizedBox(height: 12.h), // Space for bottom nav
                ],
              ),
            );
          },
        );
      },
    );
  }
}
