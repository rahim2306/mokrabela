import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Info card widget for displaying helpful messages
class InfoCard extends StatelessWidget {
  final String message;
  final String? emoji;

  const InfoCard({super.key, required this.message, this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(2.h),
      decoration: BoxDecoration(
        color: AppTheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textPrimary,
                height: 1.4,
              ),
            ),
          ),
          if (emoji != null) ...[
            SizedBox(width: 3.w),
            Container(
              width: 48.sp,
              height: 48.sp,
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(emoji!, style: TextStyle(fontSize: 24.sp)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
