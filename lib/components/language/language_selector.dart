import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// Language selector widget for AppBar
class LanguageSelector extends StatelessWidget {
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;

  const LanguageSelector({
    super.key,
    required this.onLanguageChanged,
    required this.currentLocale,
  });

  String _getLanguageShort(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'Eng';
      case 'fr':
        return 'Fra';
      case 'ar':
        return 'عربي';
      default:
        return 'Eng';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<Locale>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, size: 18.sp),
          SizedBox(width: 1.w),
          Text(
            _getLanguageShort(currentLocale),
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      onSelected: onLanguageChanged,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: const Locale('en'),
          child: Row(
            children: [
              const Text('🇬🇧'),
              SizedBox(width: 2.w),
              Text(l10n.english),
            ],
          ),
        ),
        PopupMenuItem(
          value: const Locale('fr'),
          child: Row(
            children: [
              const Text('🇫🇷'),
              const SizedBox(width: 8),
              Text(l10n.french),
            ],
          ),
        ),
        PopupMenuItem(
          value: const Locale('ar'),
          child: Row(
            children: [
              const Text('🇸🇦'),
              const SizedBox(width: 8),
              Text(l10n.arabic),
            ],
          ),
        ),
      ],
    );
  }
}
