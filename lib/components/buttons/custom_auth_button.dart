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
    // Default colors
    final bgColor = backgroundColor ?? const Color(0xFF2C5F7C);
    final fgColor = foregroundColor ?? Colors.white;
    final btnHeight = height ?? 7.h;
    final textSize = fontSize ?? 18.sp;
    final hPadding = horizontalPadding ?? 25.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding),
      child: isLoading
          ? Center(child: CircularProgressIndicator(color: bgColor))
          : Container(
              height: btnHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    bgColor,
                    Color.lerp(bgColor, const Color(0xFF5DADE2), 0.3)!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: bgColor.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: bgColor.withValues(alpha: 0.3),
                    blurRadius: 40,
                    offset: const Offset(0, 4),
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(16),
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
                                  fontWeight: FontWeight.bold,
                                  color: fgColor,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            text,
                            style: TextStyle(
                              fontSize: textSize,
                              fontWeight: FontWeight.bold,
                              color: fgColor,
                            ),
                          ),
                  ),
                ),
              ),
            ),
    );
  }
}
