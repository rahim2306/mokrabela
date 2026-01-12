import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/components/language/language_selector.dart';
import 'package:sizer/sizer.dart';

/// Custom AppBar for onboarding screens
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Function(Locale)? onLanguageChanged;
  final Locale? currentLocale;
  final bool showLanguageSelector;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.onLanguageChanged,
    this.currentLocale,
    this.showLanguageSelector = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: onBackPressed != null
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 20.sp),
              color: AppTheme.textPrimary,
              onPressed: onBackPressed,
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      centerTitle: false,
      actions: [
        if (showLanguageSelector &&
            onLanguageChanged != null &&
            currentLocale != null)
          Padding(
            padding: EdgeInsetsDirectional.only(end: 2.w),
            child: LanguageSelector(
              onLanguageChanged: onLanguageChanged!,
              currentLocale: currentLocale!,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
