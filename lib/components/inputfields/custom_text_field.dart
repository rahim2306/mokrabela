import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Custom text field widget with RTL support
class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool enabled;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 1.w, bottom: 1.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          enabled: enabled,
          onTap: onTap,
          readOnly: readOnly,
          style: TextStyle(fontSize: 16.sp, color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppTheme.textHint, fontSize: 14.sp),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppTheme.background,
            contentPadding: EdgeInsetsDirectional.symmetric(
              horizontal: 4.w,
              vertical: 1.5.h,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.border, width: 1),
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.border, width: 1),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primary, width: 2),
              borderRadius: BorderRadius.zero,
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.error, width: 1),
              borderRadius: BorderRadius.zero,
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.error, width: 2),
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ],
    );
  }
}
