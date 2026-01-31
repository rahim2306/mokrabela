import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/common/empty_states.dart';
import 'package:mokrabela/components/parent/skeletons/dashboard_skeletons.dart';
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
  final ProtocolService? protocolService;
  final FirebaseFirestore? firestore;

  const ParentHomeTab({
    super.key,
    required this.selectedChildId,
    this.protocolService,
    this.firestore,
  });

  @override
  State<ParentHomeTab> createState() => _ParentHomeTabState();
}

class _ParentHomeTabState extends State<ParentHomeTab> {
  late final ProtocolService _protocolService;
  late final FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    _protocolService = widget.protocolService ?? ProtocolService();
    _firestore = widget.firestore ?? FirebaseFirestore.instance;
  }

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
        // SKELETON: Roadmap
        if (enrollmentSnapshot.connectionState == ConnectionState.waiting) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const ProtocolRoadmapSkeleton(),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: const QuickStatsSkeleton(),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: const RecentActivitySkeleton(),
                ),
              ],
            ),
          );
        }

        final enrollment = enrollmentSnapshot.data;

        return StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('sessions')
              .where('childId', isEqualTo: widget.selectedChildId)
              .orderBy('startTime', descending: true)
              .limit(5)
              .snapshots(),
          builder: (context, sessionSnapshot) {
            // Note: We don't necessarily show skeleton here if enrollment is loaded,
            // handle waiting state for sessions gracefully inside the layout.

            final isLoadingSessions =
                sessionSnapshot.connectionState == ConnectionState.waiting;
            final sessions =
                sessionSnapshot.data?.docs.map((doc) => doc.data()).toList() ??
                [];

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),

                  // Protocol Roadmap (Horizontal Scroll)
                  ProtocolRoadmapCard(enrollment: enrollment),

                  SizedBox(height: 3.h),

                  // Quick Stats
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: isLoadingSessions
                        ? const QuickStatsSkeleton()
                        : QuickStatsCard(
                            totalSessions: sessions.length, // Placeholder logic
                            totalMinutes: sessions.isEmpty
                                ? 0
                                : sessions.fold<int>(0, (total, s) {
                                    final data = s as Map<String, dynamic>;
                                    final duration =
                                        data['duration'] as int? ?? 0;
                                    return total + (duration ~/ 60);
                                  }),
                            streakDays: enrollment?.currentWeek ?? 1,
                          ),
                  ),

                  SizedBox(height: 3.h),

                  // Recent Activity Feed
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: isLoadingSessions
                        ? const RecentActivitySkeleton()
                        : (sessions.isEmpty
                              ? EmptyStateWidget.noSessions(context)
                              : RecentActivityFeed(recentSessions: sessions)),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 0.h,
      ).copyWith(bottom: 2.h),
      child: Text(
        AppLocalizations.of(context)!.parentOverview,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
          color: AppTheme.deepBlue,
        ),
      ),
    );
  }
}
