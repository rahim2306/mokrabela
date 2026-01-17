import 'package:flutter/material.dart';
import 'package:mokrabela/models/achievement_model.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// Achievement card component with gradient background and lock states
class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final VoidCallback? onTap;

  const AchievementCard({super.key, required this.achievement, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
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
                    color: achievement.gradientColors[0].withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
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
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: achievement.isUnlocked ? 0.15 : 0.1,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: achievement.isUnlocked
                          ? [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.6),
                                blurRadius: 12,
                                spreadRadius: 3,
                              ),
                            ]
                          : [],
                    ),
                    child: Icon(
                      achievement.icon,
                      size: 28.sp,
                      color: achievement.isUnlocked
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Title
                  Text(
                    _getLocalizedTitle(l10n),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: achievement.isUnlocked
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.6),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),

                  // Description
                  Text(
                    _getLocalizedDescription(l10n),
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
                          Icon(Icons.stars, size: 14.sp, color: Colors.white),
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
                  _getRarityText(achievement.rarity),
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
    );
  }

  String _getLocalizedTitle(AppLocalizations l10n) {
    // Convert camelCase localization key to readable title
    // e.g., "achFirstBreathing" -> "First Breathing"
    final key = achievement.titleKey;

    // Remove "ach" prefix if present
    String cleaned = key.startsWith('ach') ? key.substring(3) : key;

    // Insert spaces before capital letters
    String spaced = cleaned
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();

    // Capitalize first letter
    return spaced.isEmpty ? key : spaced[0].toUpperCase() + spaced.substring(1);
  }

  String _getLocalizedDescription(AppLocalizations l10n) {
    // Convert camelCase localization key to readable description
    // e.g., "achFirstBreathingDesc" -> "Complete your first breathing exercise"
    final key = achievement.descriptionKey;

    // Remove "ach" prefix and "Desc" suffix if present
    String cleaned = key.startsWith('ach') ? key.substring(3) : key;
    cleaned = cleaned.endsWith('Desc')
        ? cleaned.substring(0, cleaned.length - 4)
        : cleaned;

    // Insert spaces before capital letters
    String spaced = cleaned
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();

    // Create a description based on the achievement
    return _generateDescription(spaced.toLowerCase());
  }

  String _generateDescription(String title) {
    // Generate contextual descriptions based on title
    if (title.contains('first')) {
      return 'Complete your $title';
    } else if (title.contains('streak')) {
      return 'Maintain a $title';
    } else if (title.contains('calm')) {
      return 'Stay calm for $title';
    } else if (title.contains('tasks')) {
      return 'Complete $title';
    } else if (title.contains('master') ||
        title.contains('champion') ||
        title.contains('expert')) {
      return 'Become a $title';
    } else {
      return title[0].toUpperCase() + title.substring(1);
    }
  }

  String _getRarityText(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return 'COMMON';
      case AchievementRarity.rare:
        return 'RARE';
      case AchievementRarity.epic:
        return 'EPIC';
      case AchievementRarity.legendary:
        return 'LEGENDARY';
    }
  }
}
