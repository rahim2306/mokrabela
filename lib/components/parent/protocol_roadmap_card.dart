import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/protocol_enrollment_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class ProtocolRoadmapCard extends StatefulWidget {
  final ProtocolEnrollment? enrollment;

  const ProtocolRoadmapCard({super.key, required this.enrollment});

  @override
  State<ProtocolRoadmapCard> createState() => _ProtocolRoadmapCardState();
}

class _ProtocolRoadmapCardState extends State<ProtocolRoadmapCard> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Auto-scroll to current week after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentWeek();
    });
  }

  @override
  void didUpdateWidget(ProtocolRoadmapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-scroll if enrollment changes
    if (oldWidget.enrollment != widget.enrollment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentWeek();
      });
    }
  }

  void _scrollToCurrentWeek() {
    if (widget.enrollment == null || !_scrollController.hasClients) return;

    final currentWeek = widget.enrollment!.calculateCurrentWeek(DateTime.now());
    // Card width is 30.w + spacing 3.w = 33.w per card
    // Scroll to show current week in the center
    final targetOffset = (currentWeek - 1) * 33.w - 10.w; // Offset to center it

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If no enrollment, show empty state or basic view
    final currentWeek =
        widget.enrollment?.calculateCurrentWeek(DateTime.now()) ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.protocolRoadmap,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.deepBlue,
                ),
              ),
              if (widget.enrollment != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 0.8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.weekLabel(currentWeek),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF8B7FEA), // Warm purple
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 20.h,
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(width: 4.w),
            itemBuilder: (context, index) {
              final weekNum = index + 1;
              return _buildWeekCard(weekNum, currentWeek);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekCard(int weekNum, int currentWeek) {
    // Status logic
    final bool isCompleted = weekNum < currentWeek;
    final bool isActive = weekNum == currentWeek;
    final bool isLocked = weekNum > currentWeek;

    // Week Titles
    final titles = [
      AppLocalizations.of(context)!.weekTitleRegulationSafety,
      AppLocalizations.of(context)!.weekTitleFocusControl,
      AppLocalizations.of(context)!.weekTitleDailyStructure,
      AppLocalizations.of(context)!.weekTitleCreativeCalm,
      AppLocalizations.of(context)!.weekTitleIntegrationReview,
    ];

    final descriptions = [
      AppLocalizations.of(context)!.weekDesc1,
      AppLocalizations.of(context)!.weekDesc2,
      AppLocalizations.of(context)!.weekDesc3,
      AppLocalizations.of(context)!.weekDesc4,
      AppLocalizations.of(context)!.weekDesc5,
    ];

    final title = (weekNum <= titles.length)
        ? titles[weekNum - 1]
        : 'Week $weekNum';

    final description = (weekNum <= descriptions.length)
        ? descriptions[weekNum - 1]
        : '';

    // Styling
    Color bgGradientStart;
    Color bgGradientEnd;

    if (isActive) {
      bgGradientStart = AppTheme.primary;
      bgGradientEnd = const Color(0xFF8B7FEA); // Warm purple instead of green
    } else if (isCompleted) {
      bgGradientStart = const Color(0xFFE0EAFC);
      bgGradientEnd = const Color(0xFFCFDEF3);
    } else {
      // Locked
      bgGradientStart = Colors.grey.shade100;
      bgGradientEnd = Colors.grey.shade200;
    }

    return Container(
      width: 32.w,
      padding: EdgeInsets.all(1.8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [bgGradientStart, bgGradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
        border: isActive ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$weekNum',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: isActive ? Colors.white : AppTheme.deepBlue,
                  ),
                ),
              ),
              if (isCompleted)
                Icon(
                  Icons.check_circle,
                  color: const Color(
                    0xFF7C6FDD,
                  ), // Soft purple instead of green
                  size: 20.sp,
                )
              else if (isLocked)
                Icon(Icons.lock, color: Colors.grey.shade400, size: 18.sp),
            ],
          ),

          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15.sp,
              height: 1.2,
              fontWeight: FontWeight.w800,
              color: isActive ? Colors.white : AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 0.5.h),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 11.5.sp,
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white.withValues(alpha: 0.9)
                    : AppTheme.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 1.h),

          // Progress bar - fetch real progress from Firestore
          _buildProgressBar(weekNum, isCompleted, isActive),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int weekNum, bool isCompleted, bool isActive) {
    if (widget.enrollment == null) {
      return _progressIndicator(
        progress: isCompleted ? 1.0 : (isActive ? 0.0 : 0.0),
        isActive: isActive,
      );
    }

    final childId = widget.enrollment!.childId;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('protocolWeeks')
          .doc('${childId}_$weekNum')
          .snapshots(),
      builder: (context, snapshot) {
        double progress = 0.0;

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null) {
            // Calculate progress based on sessions completed
            // Assuming each week should have ~14 sessions (2 per day for 7 days)
            final sessionsCompleted = data['totalSessionsCompleted'] ?? 0;
            progress = (sessionsCompleted / 14).clamp(0.0, 1.0);
          }
        } else if (isCompleted) {
          progress = 1.0;
        }

        return _progressIndicator(progress: progress, isActive: isActive);
      },
    );
  }

  Widget _progressIndicator({
    required double progress,
    required bool isActive,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.white.withValues(alpha: 0.3),
        valueColor: AlwaysStoppedAnimation<Color>(
          isActive ? Colors.white : AppTheme.primary,
        ),
        minHeight: 4,
      ),
    );
  }
}
