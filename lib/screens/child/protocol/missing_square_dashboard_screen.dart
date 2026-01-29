import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MissingSquareDashboardScreen extends StatelessWidget {
  const MissingSquareDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authService = AuthService();
    final sessionService = SessionService();
    final userId = authService.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(body: Center(child: Text("Please login")));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Light blue-grey tint
      appBar: AppBar(
        title: Text(
          l10n.protocolAnalytics,
          style: GoogleFonts.spaceGrotesk(
            color: AppTheme.deepBlue,
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: AppTheme.deepBlue,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F9FC), Colors.white],
          ),
        ),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: sessionService.getProtocolSessionsStream(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data?.docs ?? [];

            // Filter to only protocol sessions (protocolSquare 1-4)
            final protocolDocs = docs.where((doc) {
              final square = doc.data()['protocolSquare'] as int?;
              return square != null && square >= 1 && square <= 5;
            }).toList();

            // Temporarily show all sessions if no protocol sessions found
            final displayDocs = protocolDocs.isEmpty ? docs : protocolDocs;

            if (displayDocs.isEmpty) {
              return _buildEmptyState(l10n);
            }

            // Aggregate data per week
            final Map<int, List<double>> weeklyStress = {};
            final Map<int, List<double>> weeklyActivity = {};
            final Map<int, List<double>> weeklyReportedActivity = {};
            final Map<int, List<String>> weeklyMoods = {};

            for (var doc in displayDocs) {
              final data = doc.data();
              // Use protocolSquare if available, fallback to protocolWeek
              final week =
                  (data['protocolSquare'] as int?) ??
                  (data['protocolWeek'] as int?);
              if (week == null) continue;

              // Biometric fields are at root level per schema
              final stress = data['stressLevelAfter']?.toDouble() ?? 0.0;
              final activity = data['avgMotionIntensity']?.toDouble() ?? 0.0;

              // Self Awareness Data (from exerciseData)
              final exerciseData =
                  data['exerciseData'] as Map<String, dynamic>?;
              final reportedActivity =
                  exerciseData?['userReportedActivityScale']?.toDouble();
              final mood = exerciseData?['selectedEmotion'] as String?;

              weeklyStress.putIfAbsent(week, () => []).add(stress);
              weeklyActivity.putIfAbsent(week, () => []).add(activity);
              if (reportedActivity != null) {
                weeklyReportedActivity
                    .putIfAbsent(week, () => [])
                    .add(reportedActivity);
              }
              if (mood != null) {
                weeklyMoods.putIfAbsent(week, () => []).add(mood);
              }
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(
                    weeklyStress,
                    l10n.avgStressLevel,
                    Icons.favorite_rounded,
                    [const Color(0xFFFF9A9E), const Color(0xFFFECFEF)],
                    Colors.white,
                  ),
                  SizedBox(height: 3.h),
                  _buildSummaryCard(
                    weeklyActivity,
                    l10n.avgActivityLevel,
                    Icons.directions_run_rounded,
                    [const Color(0xFF84FAB0), const Color(0xFF8FD3F4)],
                    Colors.white,
                  ),
                  SizedBox(height: 3.h),
                  if (weeklyReportedActivity.isNotEmpty) ...[
                    _buildSummaryCard(
                      weeklyReportedActivity,
                      l10n.selfReportedActivity,
                      Icons.speed_rounded,
                      [const Color(0xFFF6D365), const Color(0xFFFDA085)],
                      Colors.white,
                      isValueScaledTen: true,
                    ),
                    SizedBox(height: 3.h),
                  ],
                  if (weeklyMoods.isNotEmpty) ...[
                    _buildMoodTimeline(weeklyMoods, l10n),
                    SizedBox(height: 4.h),
                  ],
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: AppTheme.deepBlue,
                        size: 18.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        l10n.weeklyBreakdown,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.deepBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  ...List.generate(5, (index) {
                    final week = index + 1;
                    final stressList = weeklyStress[week] ?? [];
                    final avgStress = stressList.isEmpty
                        ? 0.0
                        : stressList.reduce((a, b) => a + b) /
                              stressList.length;

                    return _buildWeekDetailRow(
                      l10n,
                      week,
                      avgStress,
                      stressList.length,
                    );
                  }),
                  SizedBox(height: 5.h), // Bottom padding
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics_outlined, size: 60.sp, color: Colors.grey[300]),
          SizedBox(height: 2.h),
          Text(
            l10n.noProtocolData,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            l10n.noProtocolDataDesc,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    Map<int, List<double>> data,
    String title,
    IconData icon,
    List<Color> gradientColors,
    Color iconColor, {
    bool isValueScaledTen = false,
  }) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
              SizedBox(width: 3.w),
              Text(
                title,
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 15.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final week = index + 1;
                final list = data[week] ?? [];
                final avg = list.isEmpty
                    ? 0.0
                    : list.reduce((a, b) => a + b) / list.length;

                final normalizedValue = isValueScaledTen ? avg * 10 : avg;
                final heightFactor = (normalizedValue / 100).clamp(
                  0.1,
                  1.0,
                ); // Min height 10%

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 8.w,
                      height: 10.h * heightFactor,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "W$week",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDetailRow(
    AppLocalizations l10n,
    int week,
    double avgStress,
    int sessionCount,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  week.toString(),
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.weekDetail(week),
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: AppTheme.deepBlue,
                    ),
                  ),
                  Text(
                    l10n.sessionsCount(sessionCount),
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.grey[600],
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: avgStress < 30
                  ? Colors.green.withValues(alpha: 0.1)
                  : avgStress < 70
                  ? Colors.orange.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              l10n.stressPercentage(avgStress.toInt()),
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w900,
                color: avgStress < 30
                    ? Colors.green
                    : avgStress < 70
                    ? Colors.orange
                    : Colors.red,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodTimeline(
    Map<int, List<String>> weeklyMoods,
    AppLocalizations l10n,
  ) {
    final Map<String, String> emotionEmojis = {
      'Happy': '😊',
      'Sad': '😢',
      'Angry': '😡',
      'Anxious': '😰',
      'Calm': '😌',
      'Tired': '😴',
    };

    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mood_rounded,
                  color: Colors.purple,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                l10n.dominantMood,
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppTheme.deepBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final week = index + 1;
              final moods = weeklyMoods[week] ?? [];

              String dominantEmoji = '—';
              if (moods.isNotEmpty) {
                // Find most frequent mood
                final counts = <String, int>{};
                for (var m in moods) {
                  counts[m] = (counts[m] ?? 0) + 1;
                }
                final topMood = counts.entries
                    .reduce((a, b) => a.value > b.value ? a : b)
                    .key;
                dominantEmoji = emotionEmojis[topMood] ?? '😐';
              }

              return Column(
                children: [
                  Text(dominantEmoji, style: TextStyle(fontSize: 24.sp)),
                  SizedBox(height: 1.h),
                  Text(
                    "W$week",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
