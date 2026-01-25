import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Parent Stats Tab - Analytics and reports
class ParentStatsTab extends StatelessWidget {
  final String? selectedChildId;

  const ParentStatsTab({super.key, required this.selectedChildId});

  @override
  Widget build(BuildContext context) {
    if (selectedChildId == null) {
      return Center(
        child: Text(
          'Select a child to view statistics',
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
            'Statistics & Reports',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 2.h),

          // Placeholder cards
          _buildPlaceholderCard('Aggregate Stats', Icons.pie_chart),
          SizedBox(height: 2.h),
          _buildPlaceholderCard('Weekly Chart', Icons.show_chart),
          SizedBox(height: 2.h),
          _buildPlaceholderCard('Export Reports', Icons.file_download),

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
