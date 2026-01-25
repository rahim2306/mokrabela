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
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.deepBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: sessionService.getProtocolSessionsStream(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          // Filter to only protocol sessions (protocolSquare 1-4)
          final protocolDocs = docs.where((doc) {
            final square = doc.data()['protocolSquare'] as int?;
            return square != null && square >= 1 && square <= 4;
          }).toList();

          // Temporarily show all sessions if no protocol sessions found
          final displayDocs = protocolDocs.isEmpty ? docs : protocolDocs;

          if (displayDocs.isEmpty) {
            return _buildEmptyState(l10n);
          }

          // Aggregate data per week
          final Map<int, List<double>> weeklyStress = {};
          final Map<int, List<double>> weeklyActivity = {};

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

            weeklyStress.putIfAbsent(week, () => []).add(stress);
            weeklyActivity.putIfAbsent(week, () => []).add(activity);
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
                  Colors.redAccent,
                ),
                SizedBox(height: 3.h),
                _buildSummaryCard(
                  weeklyActivity,
                  l10n.avgActivityLevel,
                  Icons.directions_run_rounded,
                  Colors.orangeAccent,
                ),
                SizedBox(height: 4.h),
                Text(
                  l10n.weeklyBreakdown,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.deepBlue,
                  ),
                ),
                SizedBox(height: 2.h),
                ...List.generate(5, (index) {
                  final week = index + 1;
                  final stressList = weeklyStress[week] ?? [];
                  final avgStress = stressList.isEmpty
                      ? 0.0
                      : stressList.reduce((a, b) => a + b) / stressList.length;

                  return _buildWeekDetailRow(
                    l10n,
                    week,
                    avgStress,
                    stressList.length,
                  );
                }),
              ],
            ),
          );
        },
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
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.sp),
              SizedBox(width: 3.w),
              Text(
                title,
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
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
                final heightFactor = (avg / 100).clamp(0.05, 1.0);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 8.w,
                      height: 10.h * heightFactor,
                      decoration: BoxDecoration(
                        color: list.isEmpty
                            ? Colors.grey[100]
                            : color.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "W$week",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
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
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.weekDetail(week),
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                l10n.sessionsCount(sessionCount),
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.grey,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                l10n.stressPercentage(avgStress.toInt()),
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
