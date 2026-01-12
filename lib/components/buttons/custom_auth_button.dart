import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// A reusable custom elevated button for authentication screens
class CustomAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? horizontalPadding;
  final double? height;
  final double? fontSize;
  final IconData? icon;

  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.horizontalPadding,
    this.height,
    this.fontSize,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Therapeutic colors - soft, calming teal palette
    final bgColor =
        backgroundColor ?? const Color(0xFF4ECDC4); // Soft teal (primary)
    final fgColor = foregroundColor ?? Colors.white;
    final btnHeight = height ?? 7.h;
    final textSize = fontSize ?? 18.sp;
    final hPadding = horizontalPadding ?? 25.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(color: bgColor, strokeWidth: 3),
            )
          : Container(
              height: btnHeight,
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
                borderRadius: BorderRadius.circular(16),
                // Gentle, therapeutic shadows
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFF4ECDC4,
                    ).withValues(alpha: 0.25), // Softer shadow
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(
                      0xFF4ECDC4,
                    ).withValues(alpha: 0.15), // Very soft glow
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
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.white.withValues(
                    alpha: 0.2,
                  ), // Gentle ripple
                  highlightColor: Colors.white.withValues(alpha: 0.1),
                  child: Center(
                    child: icon != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, size: textSize, color: fgColor),
                              SizedBox(width: 2.w),
                              Text(
                                text,
                                style: TextStyle(
                                  fontSize: textSize,
                                  fontWeight:
                                      FontWeight.w700, // Bold but not too heavy
                                  color: fgColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            text,
                            style: TextStyle(
                              fontSize: textSize,
                              fontWeight:
                                  FontWeight.w700, // Bold but not too heavy
                              color: fgColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
              ),
            ),
    );
  }
}
