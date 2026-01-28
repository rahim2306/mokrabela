import 'package:flutter/material.dart';
import 'package:mokrabela/components/parent/profile/child_info_card.dart';
import 'package:mokrabela/components/parent/profile/recent_achievements_card.dart';
import 'package:mokrabela/components/parent/profile/watch_status_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/achievement_model.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/screens/parent/child_management_screen.dart';
import 'package:mokrabela/services/parent_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Parent Profile Tab - Child management and account settings
class ParentProfileTab extends StatelessWidget {
  final String? selectedChildId;

  const ParentProfileTab({super.key, required this.selectedChildId});

  @override
  Widget build(BuildContext context) {
    final parentService = ParentService();
    final l10n = AppLocalizations.of(context)!;

    if (selectedChildId == null) {
      return _buildEmptyState(context, l10n);
    }

    return Stack(
      children: [
        // Background Decorations
        Positioned(
          top: -15.h,
          left: -15.w,
          child: Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primary.withValues(alpha: 0.04),
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: -20.w,
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF8B7FEA).withValues(alpha: 0.04),
            ),
          ),
        ),

        StreamBuilder<UserModel?>(
          stream: Stream.fromFuture(
            parentService.getChildDetails(selectedChildId!),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final child = snapshot.data;
            if (child == null) {
              return _buildEmptyState(context, l10n);
            }

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(5.w, 4.h, 5.w, 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    l10n.childProfile,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.deepBlue,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 3.h),

                  // Child Info Card (with integrated actions)
                  ChildInfoCard(
                    child: child,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChildManagementScreen(child: child),
                        ),
                      );
                    },
                    onSendMessage: () {
                      // TODO: Navigate to messaging screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.sendMessageDesc),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    onSendSticker: () {
                      // TODO: Show sticker selector dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.sendStickerDesc),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 3.h),

                  // Recent Achievements
                  StreamBuilder<List<Achievement>>(
                    stream: parentService.getRecentAchievements(child.uid),
                    builder: (context, achievementSnapshot) {
                      final achievements = achievementSnapshot.data ?? [];
                      return RecentAchievementsCard(achievements: achievements);
                    },
                  ),
                  SizedBox(height: 3.h),

                  // Watch Status Card
                  WatchStatusCard(settings: child.watchSettings),
                  SizedBox(height: 3.h),

                  SizedBox(height: 12.h), // Space for bottom nav
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Stack(
      children: [
        Positioned(
          top: 10.h,
          right: -10.w,
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primary.withValues(alpha: 0.05),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.child_care_rounded,
                    size: 80.sp,
                    color: AppTheme.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  l10n.noChildSelected,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.deepBlue,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  l10n.createChildToStart,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/parent/create-child');
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: Text(l10n.createChildAccountLabel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 2.2.h,
                    ),
                    elevation: 10,
                    shadowColor: AppTheme.primary.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
