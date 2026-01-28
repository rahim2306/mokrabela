import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class ChildInfoCard extends StatelessWidget {
  final UserModel child;
  final VoidCallback onTap;
  final VoidCallback? onSendReward;

  const ChildInfoCard({
    super.key,
    required this.child,
    required this.onTap,
    this.onSendReward,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Info Section (Clickable)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
                bottom: Radius.circular(4),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5.w, 4.w, 5.w, 2.w),
                child: Row(
                  children: [
                    // Hero for Avatar
                    Hero(
                      tag: 'child_profile_${child.uid}',
                      child: Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: 32.sp,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            child.name,
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.deepBlue,
                              letterSpacing: -0.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            l10n.ageYearsOld(child.profile.age.toString()),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14.sp,
                      color: AppTheme.textSecondary.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(
              color: AppTheme.backgroundLight,
              thickness: 1,
              height: 2.h,
            ),
          ),

          // Action Buttons Section
          Padding(
            padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 4.w),
            child: _buildActionButton(
              icon: Icons.stars_rounded,
              label: l10n.rewardsAndEncouragement,
              color: AppTheme.primary,
              onTap: onSendReward ?? () {},
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isFullWidth = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          ),
          child: isFullWidth
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color, size: 20.sp),
                    SizedBox(width: 2.w),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: color, size: 20.sp),
                    SizedBox(height: 0.5.h),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
