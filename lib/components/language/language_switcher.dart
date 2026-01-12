import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Language switcher button widget
class LanguageSwitcher extends StatelessWidget {
  final Locale currentLocale;
  final Function(Locale) onLanguageChanged;

  const LanguageSwitcher({
    super.key,
    required this.currentLocale,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: Container(
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, color: const Color(0xFF2C5F7C), size: 20.sp),
            SizedBox(width: 1.5.w),
            Text(
              _getLanguageCode(currentLocale),
              style: TextStyle(
                color: const Color(0xFF2C5F7C),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onSelected: onLanguageChanged,
      itemBuilder: (BuildContext context) => [
        _buildLanguageMenuItem(
          const Locale('en'),
          'English',
          'EN',
          currentLocale,
        ),
        _buildLanguageMenuItem(
          const Locale('fr'),
          'Français',
          'FR',
          currentLocale,
        ),
        _buildLanguageMenuItem(
          const Locale('ar'),
          'العربية',
          'AR',
          currentLocale,
        ),
      ],
    );
  }

  PopupMenuItem<Locale> _buildLanguageMenuItem(
    Locale locale,
    String languageName,
    String languageCode,
    Locale currentLocale,
  ) {
    final isSelected = locale.languageCode == currentLocale.languageCode;

    return PopupMenuItem<Locale>(
      value: locale,
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected
                ? const Color(0xFF2C5F7C)
                : const Color(0xFF9E9E9E),
            size: 20.sp,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              languageName,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF2C5F7C)
                    : const Color(0xFF2C3E50),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
          Text(
            languageCode,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF2C5F7C)
                  : const Color(0xFF9E9E9E),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _getLanguageCode(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'EN';
      case 'fr':
        return 'FR';
      case 'ar':
        return 'AR';
      default:
        return 'EN';
    }
  }
}
