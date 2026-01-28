import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/achievement_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/utils/localization_helpers.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RecentAchievementsCard extends StatelessWidget {
  final List<Achievement> achievements;

  const RecentAchievementsCard({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.deepBlue.withValues(alpha: 0.05),
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
              Icon(
                Icons.emoji_events_rounded,
                color: AppTheme.primary,
                size: 20.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                l10n.recentAchievements,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.deepBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          if (achievements.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 48.sp,
                      color: AppTheme.textSecondary.withValues(alpha: 0.3),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      l10n.noAchievementsYet,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...achievements.take(3).map((achievement) {
              return Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: _buildAchievementItem(achievement, l10n),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(Achievement achievement, AppLocalizations l10n) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.5.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFFD700).withValues(alpha: 0.2),
                const Color(0xFFFFA500).withValues(alpha: 0.2),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getAchievementIcon(achievement.category),
            color: const Color(0xFFFFB800),
            size: 20.sp,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // Use the localized title via helper
                l10n.getAchievementString(achievement.titleKey),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.deepBlue,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 0.3.h),
              Text(
                achievement.unlockedAt != null
                    ? _formatDate(achievement.unlockedAt!)
                    : 'Not unlocked',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getAchievementIcon(AchievementCategory category) {
    switch (category) {
      case AchievementCategory.streaks:
        return Icons.local_fire_department_rounded;
      case AchievementCategory.exercise:
        return Icons.directions_walk_rounded;
      case AchievementCategory.calm:
        return Icons.spa_rounded;
      case AchievementCategory.milestones:
        return Icons.emoji_events_rounded;
      case AchievementCategory.special:
        return Icons.star_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat.jm().format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat.MMMd().format(date);
    }
  }
}
