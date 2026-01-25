import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/components/buttons/primary_button.dart';
import 'package:sizer/sizer.dart';

/// Settings screen with language selection and logout
class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;
  final String userName;

  const SettingsScreen({
    super.key,
    required this.onLanguageChanged,
    required this.currentLocale,
    required this.userName,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Locale _selectedLocale;
  int _selectedGoal = 30; // Default
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.currentLocale;
    _loadCurrentGoal();
  }

  Future<void> _loadCurrentGoal() async {
    final user = await _authService.currentUser;
    if (user != null) {
      final userDetails = await _authService.getUserDetails(user.uid);
      if (userDetails != null && mounted) {
        setState(() {
          // Default to 30 if not set
          _selectedGoal = userDetails.appSettings.dailyCalmGoalMinutes;
        });
      }
    }
  }

  Future<void> _updateGoal(int newGoal) async {
    setState(() => _selectedGoal = newGoal);
    final user = await _authService.currentUser; // Await the Future<User?>
    if (user != null) {
      // Update settings
      final settings = AppSettings(dailyCalmGoalMinutes: newGoal);
      await _authService.updateAppSettings(user.uid, settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // final authService = AuthService(); // Removed as _authService is now a state variable

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAFAFA), // Off-white at top
              Color.fromARGB(
                255,
                187,
                222,
                230,
              ), // Soft teal/mint in middle (greeting area)
              Color(0xFFFAFAFA), // Off-white at bottom
            ],
            stops: [0.0, 0.11, 0.7], // Color concentrated in upper-middle area
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppTheme.deepBlue,
                    size: 24.sp,
                  ),
                  padding: EdgeInsets.zero,
                ),

                SizedBox(height: 2.h),

                // Greeting header
                Text(
                  l10n.goodMorning,
                  style: TextStyle(
                    fontSize: (26 / 1.2).sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.deepBlue.withValues(alpha: 0.6),
                    height: 1.0,
                  ),
                ),
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.deepBlue,
                    letterSpacing: -0.5,
                    height: 1.0,
                  ),
                ),

                SizedBox(height: 4.h),

                // Settings card
                Container(
                  padding: EdgeInsets.all(2.5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Language selector
                      _buildSettingTile(
                        icon: Icons.language,
                        title: l10n.language,
                        trailing: _buildLanguageDropdown(context),
                      ),

                      const Divider(height: 30),

                      // Daily Calm Goal selector
                      _buildSettingTile(
                        icon: Icons.timer,
                        title: l10n.dailyCalmGoal,
                        trailing: _buildCalmGoalDropdown(context),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Logout button using PrimaryButton component with red gradient
                PrimaryButton(
                  text: l10n.logout,
                  gradientColors: const [
                    Color(0xFFFF6B6B), // Soft red
                    Color(0xFFFF9B9B), // Light coral
                  ],
                  onPressed: () async {
                    await _authService.signOut();
                    // Pop settings screen so AuthGate can navigate to onboarding
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),

                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.deepBlue, size: 22.sp),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppTheme.deepBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    final languageMap = {'en': 'English', 'fr': 'Français', 'ar': 'العربية'};

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButton<String>(
        value: _selectedLocale.languageCode,
        dropdownColor: Colors.white,
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: AppTheme.primary),
        style: TextStyle(
          fontSize: 14.sp,
          color: AppTheme.deepBlue,
          fontWeight: FontWeight.w600,
        ),
        items: languageMap.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLocale = Locale(newValue);
            });
            widget.onLanguageChanged(Locale(newValue));
          }
        },
      ),
    );
  }

  Widget _buildCalmGoalDropdown(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final goals = [10, 15, 20, 30, 45, 60];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButton<int>(
        value: _selectedGoal,
        dropdownColor: Colors.white,
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: AppTheme.primary),
        style: TextStyle(
          fontSize: 14.sp,
          color: AppTheme.deepBlue,
          fontWeight: FontWeight.w600,
        ),
        items: goals.map((minutes) {
          return DropdownMenuItem<int>(
            value: minutes,
            child: Text('$minutes ${l10n.minutes}'),
          );
        }).toList(),
        onChanged: (int? newValue) {
          if (newValue != null) {
            _updateGoal(newValue);
          }
        },
      ),
    );
  }
}
