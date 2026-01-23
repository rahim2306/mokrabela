import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/models/achievement_model.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/utils/localization_helpers.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

/// Full-screen dialog showing achievement details with Hero animation
class AchievementDetailDialog extends StatelessWidget {
  final Achievement achievement;

  const AchievementDetailDialog({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        body: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent closing when tapping card
            child: Hero(
              tag: 'achievement_${achievement.id}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 85.w,
                  constraints: BoxConstraints(maxHeight: 75.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: achievement.isUnlocked
                          ? achievement.gradientColors
                          : [
                              achievement.gradientColors[0].withValues(
                                alpha: 0.3,
                              ),
                              achievement.gradientColors[1].withValues(
                                alpha: 0.3,
                              ),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: achievement.isUnlocked
                            ? achievement.gradientColors[0].withValues(
                                alpha: 0.6,
                              )
                            : Colors.black.withValues(alpha: 0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(2.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Close button
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        // Large icon
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                            boxShadow: achievement.isUnlocked
                                ? [
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            achievement.icon,
                            size: 20.w,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Title
                        Text(
                          l10n.getAchievementString(achievement.titleKey),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 2.h),

                        // Description
                        Text(
                          l10n.getAchievementString(achievement.descriptionKey),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 3.h),

                        // Rarity badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            l10n.getAchievementString(
                              achievement.rarity.name.toUpperCase(),
                            ),
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Progress section
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.achProgress,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${achievement.currentValue}/${achievement.targetValue}',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: achievement.progress,
                                  minHeight: 8,
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.2,
                                  ),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // How to unlock / Unlock date
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (achievement.isUnlocked) ...[
                                // Unlocked date
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      l10n.achUnlockedTitle,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                if (achievement.unlockedAt != null)
                                  Text(
                                    DateFormat(
                                      'MMMM d, yyyy',
                                      l10n.localeName,
                                    ).format(achievement.unlockedAt!),
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),
                              ] else ...[
                                // How to unlock
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      l10n.howToUnlock,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  _getUnlockInstructions(),
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Points badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.stars,
                                size: 18.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                l10n.achPointsCount(achievement.points),
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getUnlockInstructions() {
    final remaining = achievement.targetValue - achievement.currentValue;

    switch (achievement.id) {
      case 'breathing_first':
        return 'Complete your first breathing exercise to unlock this achievement.';
      case 'breathing_5':
      case 'breathing_10':
      case 'breathing_master':
        return 'Complete $remaining more breathing exercise${remaining > 1 ? 's' : ''} to unlock.';
      case 'focus_first':
        return 'Complete your first focus game to unlock this achievement.';
      case 'focus_champion':
        return 'Complete $remaining more focus game${remaining > 1 ? 's' : ''} to unlock.';
      case 'music_beginner':
      case 'music_expert':
        return 'Listen to $remaining more music track${remaining > 1 ? 's' : ''} (10+ seconds each) to unlock.';
      case 'story_starter':
      case 'story_master':
        return 'Complete $remaining more stor${remaining > 1 ? 'ies' : 'y'} to unlock.';
      case 'calm_10min':
      case 'calm_30min':
      case 'calm_1hour':
        return 'Spend $remaining more minute${remaining > 1 ? 's' : ''} in calm activities to unlock.';
      case 'first_day':
        return 'Complete any activity to unlock this achievement.';
      case 'streak_3':
      case 'streak_7':
      case 'streak_30':
        return 'Complete activities for $remaining more consecutive day${remaining > 1 ? 's' : ''} to unlock.';
      case 'tasks_100':
      case 'tasks_500':
      case 'tasks_1000':
        return 'Complete $remaining more task${remaining > 1 ? 's' : ''} to unlock.';
      default:
        return 'Keep practicing to unlock this achievement!';
    }
  }
}
