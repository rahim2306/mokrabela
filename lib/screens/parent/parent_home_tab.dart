import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Parent Home Tab - Protocol overview and recent activity
class ParentHomeTab extends StatelessWidget {
  final String? selectedChildId;

  const ParentHomeTab({super.key, required this.selectedChildId});

  @override
  Widget build(BuildContext context) {
    if (selectedChildId == null) {
      return Center(
        child: Text(
          'Select a child to view their progress',
          style: TextStyle(fontSize: 14.sp, color: AppTheme.textSecondary),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Overview',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 2.h),

          // Placeholder cards
          _buildPlaceholderCard('Protocol Roadmap', Icons.timeline),
          SizedBox(height: 2.h),
          _buildPlaceholderCard('Quick Stats', Icons.analytics),
          SizedBox(height: 2.h),
          _buildPlaceholderCard('Recent Activity', Icons.history),

          SizedBox(height: 10.h), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildPlaceholderCard(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 32.sp, color: AppTheme.primary),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.deepBlue,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Coming soon...',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
