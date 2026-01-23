import 'package:flutter/material.dart';
import 'package:mokrabela/models/achievement_model.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/utils/localization_helpers.dart';
import 'package:sizer/sizer.dart';

/// Achievement card component with gradient background and lock states
class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final VoidCallback? onTap;

  const AchievementCard({super.key, required this.achievement, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Hero(
      tag: 'achievement_${achievement.id}',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: achievement.isUnlocked
                    ? achievement.gradientColors
                    : [
                        achievement.gradientColors[0].withValues(alpha: 0.3),
                        achievement.gradientColors[1].withValues(alpha: 0.3),
                      ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: achievement.isUnlocked
                  ? [
                      BoxShadow(
                        color: achievement.gradientColors[0].withValues(
                          alpha: 0.6,
                        ),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: achievement.gradientColors[1].withValues(
                          alpha: 0.4,
                        ),
                        blurRadius: 24,
                        spreadRadius: 0,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Stack(
              children: [
                // Main content
                Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon with glow effect
                      Container(
                        padding: EdgeInsets.all(2.5.w),
                        decoration: BoxDecoration(
                          color: achievement.isUnlocked
                              ? Colors.white.withValues(alpha: 0.25)
                              : Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          boxShadow: achievement.isUnlocked
                              ? [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          achievement.icon,
                          size: 30.sp,
                          color: achievement.isUnlocked
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Title
                      Text(
                        l10n.getAchievementString(achievement.titleKey),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w900,
                          color: achievement.isUnlocked
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.7),
                          height: 1.2,
                          shadows: achievement.isUnlocked
                              ? [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),

                      // Description
                      Text(
                        l10n.getAchievementString(achievement.descriptionKey),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: achievement.isUnlocked
                              ? Colors.white.withValues(alpha: 0.9)
                              : Colors.white.withValues(alpha: 0.5),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const Spacer(),

                      // Points badge (for unlocked achievements)
                      if (achievement.isUnlocked) ...[
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.stars,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                '+${achievement.points}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Lock overlay for locked achievements
                if (!achievement.isUnlocked)
                  Positioned(
                    top: 2.w,
                    right: 2.w,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock,
                        size: 18.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),

                // Rarity badge
                Positioned(
                  bottom: 2.w,
                  right: 2.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.5.w,
                      vertical: 0.3.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      l10n.getAchievementString(
                        achievement.rarity.name.toUpperCase(),
                      ),
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.9),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
