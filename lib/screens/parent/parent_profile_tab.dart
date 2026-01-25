import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Parent Profile Tab - Child management and account settings
class ParentProfileTab extends StatelessWidget {
  final String? selectedChildId;

  const ParentProfileTab({super.key, required this.selectedChildId});

  @override
  Widget build(BuildContext context) {
    // Show "create child" prompt if no child is selected (including when there are no children)
    if (selectedChildId == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.child_care_outlined,
                size: 80.sp,
                color: AppTheme.primary.withValues(alpha: 0.3),
              ),
              SizedBox(height: 3.h),
              Text(
                'No Child Selected',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.deepBlue,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Create a child account to get started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppTheme.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to create child screen
                  Navigator.pushNamed(context, '/parent/create-child');
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Child Account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
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
            'Child Profile',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 2.h),

          // Placeholder cards
          _buildPlaceholderCard('Child Information', Icons.person),
          SizedBox(height: 2.h),
          _buildPlaceholderCard('Watch Status', Icons.watch),
          SizedBox(height: 2.h),
          _buildPlaceholderCard('Account Management', Icons.settings),
          SizedBox(height: 2.h),

          // Removed duplicate Create Child Button as it's now in the top bar dropdown
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
