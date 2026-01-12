import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Primary button widget matching the onboarding design
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 52, // Will be converted to 6.5.h in build
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height == 52 ? 6.5.h : height;

    return SizedBox(
      width: width ?? double.infinity,
      height: buttonHeight,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppTheme.primary,
                strokeWidth: 3,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                // Soft therapeutic gradient - teal to light aqua
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4ECDC4), // Soft teal
                    Color(0xFF6FD9D1), // Light aqua
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                // Gentle, therapeutic glow
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(
                      alpha: 0.25,
                    ), // Softer shadow
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: AppTheme.primary.withValues(
                      alpha: 0.15,
                    ), // Very soft glow
                    blurRadius: 24,
                    offset: const Offset(0, 2),
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Colors.white.withValues(
                    alpha: 0.2,
                  ), // Gentle ripple
                  highlightColor: Colors.white.withValues(alpha: 0.1),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
