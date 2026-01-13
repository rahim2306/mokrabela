import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Kids Achievements Screen - Rewards and achievements list
class KidsAchievementsScreen extends StatelessWidget {
  const KidsAchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
        children: [
          SizedBox(height: 4.h),
          // Achievements content
          _buildAchievementsContent(l10n),
          SizedBox(height: 10.h), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildAchievementsContent(AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.vibrantOrange.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.emoji_events, size: 60.sp, color: AppTheme.vibrantOrange),
          SizedBox(height: 2.h),
          Text(
            l10n.achievements,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Coming soon!',
            style: TextStyle(fontSize: 14.sp, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
