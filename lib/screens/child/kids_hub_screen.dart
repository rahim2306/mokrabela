import 'package:flutter/material.dart';
import 'package:mokrabela/components/cards/daily_progress_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/components/cards/exercise_card.dart';
import 'package:mokrabela/screens/child/breathing/breathing_exercises_menu_screen.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:sizer/sizer.dart';

/// Kids Hub Screen - Horizontal swipeable exercise cards
class KidsHubScreen extends StatefulWidget {
  const KidsHubScreen({super.key});

  @override
  State<KidsHubScreen> createState() => _KidsHubScreenState();
}

class _KidsHubScreenState extends State<KidsHubScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  final AuthService _authService = AuthService();
  int _currentPage = 0;
  String _firstName = 'Friend';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = _authService.currentUser;
    if (user != null) {
      final userModel = await _authService.getUserDetails(user.uid);
      if (userModel != null && userModel.name.isNotEmpty) {
        setState(() {
          // Extract first name from "firstname lastname" format
          final nameParts = userModel.name.trim().split(' ');
          if (nameParts.isNotEmpty) {
            final firstName = nameParts[0];
            // Capitalize first letter
            _firstName = firstName.isEmpty
                ? 'Friend'
                : firstName[0].toUpperCase() +
                      firstName.substring(1).toLowerCase();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final exercises = [
      {
        'title': l10n.breathingExercise,
        'icon': Icons.air,
        'gradient': const [Color(0xFF4ECDC4), Color(0xFF44A08D)],
      },
      {
        'title': l10n.focusGames,
        'icon': Icons.track_changes,
        'gradient': const [Color(0xFF9B8FD9), Color(0xFF7B6FB9)],
      },
      {
        'title': l10n.calmMusic,
        'icon': Icons.music_note,
        'gradient': const [Color(0xFF6DD5ED), Color(0xFF2193B0)],
      },
      {
        'title': l10n.stories,
        'icon': Icons.menu_book,
        'gradient': const [Color(0xFFFFE259), Color(0xFFFFA751)],
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome greeting (with padding)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                  _firstName,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.deepBlue,
                    letterSpacing: -0.5,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          // Daily Progress Card (with padding)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: const DailyProgressCard(),
          ),
          SizedBox(height: 3.h),
          // Horizontal scrollable exercise cards
          SizedBox(
            height: 22.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: ExerciseCard(
                    title: exercise['title'] as String,
                    icon: exercise['icon'] as IconData,
                    gradient: exercise['gradient'] as List<Color>,
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const BreathingExercisesMenuScreen(),
                          ),
                        );
                      } else {
                        _showPlaceholder(context, exercise['title'] as String);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(exercises.length, (index) {
              final isActive = _currentPage == index;
              final activeColor =
                  (exercises[_currentPage]['gradient'] as List<Color>)[0];

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: isActive ? 8.w : 2.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: isActive
                      ? activeColor
                      : activeColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
          SizedBox(height: 10.h), // Space for bottom nav
        ],
      ),
    );
  }

  void _showPlaceholder(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Navigation placeholder'),
        backgroundColor: AppTheme.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
