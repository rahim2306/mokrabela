import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/screens/child/protocol/daily_tasks_screen.dart';
import 'package:mokrabela/screens/protocol/self_awareness_screen.dart';
import 'package:mokrabela/screens/protocol/self_regulation_screen.dart';
import 'package:mokrabela/screens/protocol/psychological_calming_screen.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Kids Protocol Screen - The Missing Square Protocol with 4 squares
class KidsProtocolScreen extends StatefulWidget {
  const KidsProtocolScreen({super.key});

  @override
  State<KidsProtocolScreen> createState() => _KidsProtocolScreenState();
}

class _KidsProtocolScreenState extends State<KidsProtocolScreen> {
  final AuthService _authService = AuthService();
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
        if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 1.h),
          SizedBox(height: 1.h),
          // Hub-style Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // "Hello"
                Text(
                  l10n.helloLabel,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: (26 / 1.2).sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.deepBlue.withValues(alpha: 0.6),
                    height: 1.0,
                  ),
                ),
                // Name
                Text(
                  _firstName,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.deepBlue,
                    letterSpacing: -0.5,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: 1.h),
                // "Let's start protocol"
                Text(
                  l10n.letsStartProtocol,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.deepBlue.withValues(alpha: 0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 0.h),
          // 4 Squares Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 3.h,
            crossAxisSpacing: 4.w,
            childAspectRatio: 1.0,
            children: [
              _buildSquareCard(
                context,
                title: l10n.square1Title,
                description: l10n.square1Desc,
                icon: Icons.psychology_rounded,
                gradient: const [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                heroTag: 'awareness_card',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelfAwarenessScreen(),
                    ),
                  );
                },
              ),
              _buildSquareCard(
                context,
                title: l10n.square2Title,
                description: l10n.square2Desc,
                icon: Icons.air_rounded,
                gradient: const [Color(0xFF667EEA), Color(0xFF764BA2)],
                heroTag: 'regulation_card',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelfRegulationScreen(),
                    ),
                  );
                },
              ),
              _buildSquareCard(
                context,
                title: l10n.square3Title,
                description: l10n.square3Desc,
                icon: Icons.task_alt_rounded,
                gradient: const [Color(0xFFFFE259), Color(0xFFFFA751)],
                heroTag: 'daily_tasks_card',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DailyTasksScreen(),
                    ),
                  );
                },
              ),
              _buildSquareCard(
                context,
                title: l10n.square4Title,
                description: l10n.square4Desc,
                icon: Icons.self_improvement_rounded,
                gradient: const [Color(0xFFF093FB), Color(0xFFF5576C)],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PsychologicalCalmingScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 14.h), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildSquareCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
    String? heroTag,
  }) {
    Widget cardContent = Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(3.h),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 28.sp, color: Colors.white),
              ),
              SizedBox(height: 2.h),
              // Title
              Text(
                title,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 0.8.h),
              // Description
              Text(
                description,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );

    if (heroTag != null) {
      cardContent = Hero(
        tag: heroTag,
        child: Material(color: Colors.transparent, child: cardContent),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        splashColor: Colors.white.withValues(alpha: 0.3),
        highlightColor: Colors.white.withValues(alpha: 0.1),
        child: cardContent,
      ),
    );
  }
}
