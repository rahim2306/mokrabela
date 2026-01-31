import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/parent/activity_feed.dart';
import 'package:mokrabela/components/parent/protocol_roadmap_card.dart';
import 'package:mokrabela/components/parent/quick_stats_card.dart';
import 'package:mokrabela/components/parent/skeletons/dashboard_skeletons.dart';
import 'package:mokrabela/models/protocol_enrollment_model.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class StudentProgressScreen extends StatefulWidget {
  final UserModel student;

  const StudentProgressScreen({super.key, required this.student});

  @override
  State<StudentProgressScreen> createState() => _StudentProgressScreenState();
}

class _StudentProgressScreenState extends State<StudentProgressScreen> {
  final ProtocolService _protocolService = ProtocolService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.kidsBackgroundGradient,
        ),
        child: Column(
          children: [
            SizedBox(height: 5.h), // Top padding for status bar
            // Sticky-like Top Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 226, 240, 243), // Soft teal
                      Color.fromARGB(255, 187, 222, 230), // Soft teal
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Back Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18.sp,
                          color: AppTheme.deepBlue,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    // Title
                    Expanded(
                      child: Text(
                        widget.student.name,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.deepBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Main Content
            Expanded(
              child: StreamBuilder<ProtocolEnrollment?>(
                stream: _protocolService.getEnrollmentStream(
                  widget.student.uid,
                ),
                builder: (context, enrollmentSnapshot) {
                  if (enrollmentSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    // Use skeleton but wrap in SingleChildScrollView for Column compatibility
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      child: const Column(
                        children: [
                          ProtocolRoadmapSkeleton(),
                          SizedBox(height: 20),
                          QuickStatsSkeleton(),
                        ],
                      ),
                    );
                  }

                  final enrollment = enrollmentSnapshot.data;

                  return StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('sessions')
                        .where('childId', isEqualTo: widget.student.uid)
                        .orderBy('startTime', descending: true)
                        .limit(5)
                        .snapshots(),
                    builder: (context, sessionSnapshot) {
                      final sessions =
                          sessionSnapshot.data?.docs
                              .map((doc) => doc.data())
                              .toList() ??
                          [];

                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Status Badge
                            _buildStatusBadge(enrollment),
                            SizedBox(height: 2.h),

                            // Protocol Roadmap
                            Text(
                              "Protocol Progress",
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.deepBlue,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            ProtocolRoadmapCard(enrollment: enrollment),

                            SizedBox(height: 3.h),

                            // Quick Stats
                            QuickStatsCard(
                              totalSessions:
                                  sessions.length, // Placeholder logic
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

                            SizedBox(height: 3.h),

                            // Recent Activity
                            Text(
                              "Recent Activity",
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.deepBlue,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            sessions.isEmpty
                                ? Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Text("No recent activity"),
                                    ),
                                  )
                                : RecentActivityFeed(recentSessions: sessions),

                            SizedBox(height: 5.h),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ProtocolEnrollment? enrollment) {
    if (enrollment == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, color: Colors.orange, size: 16),
            SizedBox(width: 2.w),
            Text(
              "Not Enrolled",
              style: TextStyle(
                color: Colors.orange[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, color: AppTheme.primary, size: 16),
          SizedBox(width: 2.w),
          Text(
            "Week ${enrollment.currentWeek} Active",
            style: TextStyle(
              color: AppTheme.deepBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
