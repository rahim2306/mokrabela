import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

enum TimeRange { week, month, fiveWeeks }

class TimeRangeSelector extends StatelessWidget {
  final TimeRange selected;
  final ValueChanged<TimeRange> onChanged;

  const TimeRangeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity, // extend all the way
      padding: EdgeInsets.all(0.8.h), // Slightly more padding container
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16), // Slightly more rounded
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildOption(l10n.timeRangeWeek, TimeRange.week)),
          SizedBox(width: 2.w), // More spacing
          Expanded(child: _buildOption(l10n.timeRangeMonth, TimeRange.month)),
          SizedBox(width: 2.w),
          Expanded(
            child: _buildOption(l10n.timeRangeFiveWeeks, TimeRange.fiveWeeks),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String label, TimeRange value) {
    final isSelected = selected == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(vertical: 1.8.h), // Bigger vertically
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B7FEA) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF8B7FEA).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center, // Center text
        child: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 13.sp, // Bigger text
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 1, // Prevent overflow
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
