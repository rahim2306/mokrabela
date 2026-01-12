import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Custom radio option widget with icon and text
class RadioOption<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String text;
  final IconData? icon;
  final ValueChanged<T?> onChanged;

  const RadioOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.text,
    this.icon,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsetsDirectional.all(2.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.secondary.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppTheme.secondary : AppTheme.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Custom radio indicator
            Container(
              width: 24.sp,
              height: 24.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppTheme.secondary : AppTheme.border,
                  width: 2,
                ),
                color: isSelected ? AppTheme.secondary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 3.w),
            // Icon if provided
            if (icon != null) ...[
              Icon(
                icon,
                size: 20.sp,
                color: isSelected ? AppTheme.secondary : AppTheme.textSecondary,
              ),
              SizedBox(width: 3.w),
            ],
            // Text
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  color: isSelected
                      ? AppTheme.textPrimary
                      : AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
