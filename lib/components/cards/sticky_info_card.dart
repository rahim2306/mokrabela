import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// A collapsible info card that sticks to the bottom of the screen
/// Can be used across different activity screens
class StickyInfoCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool initiallyExpanded;

  const StickyInfoCard({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.tips_and_updates,
    this.iconColor = const Color(0xFFFFA000), // Amber
    this.iconBackgroundColor = const Color(0xFFFFE082), // Light Amber
    this.initiallyExpanded = true,
  });

  @override
  State<StickyInfoCard> createState() => _StickyInfoCardState();
}

class _StickyInfoCardState extends State<StickyInfoCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.h),
        padding: EdgeInsets.all(3.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFDFBF7), // Off-white / Cream
              const Color(0xFFF4F8F9), // Very light cool grey
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppTheme.deepBlue.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, -4),
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.6),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: widget.iconBackgroundColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.deepBlue,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: AppTheme.deepBlue,
                  size: 24.sp,
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            height: 1.6,
                            color: AppTheme.deepBlue.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  /// Get the height of the card based on expanded state
  /// Use this for padding calculations in parent widgets
  double get height => _isExpanded ? 25.h : 12.h;

  /// Check if card is expanded
  bool get isExpanded => _isExpanded;
}
