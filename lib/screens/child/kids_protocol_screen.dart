import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/screens/child/protocol/daily_tasks_screen.dart';
import 'package:mokrabela/screens/protocol/self_awareness_screen.dart';
import 'package:mokrabela/screens/protocol/self_regulation_screen.dart';
import 'package:mokrabela/screens/protocol/psychological_calming_screen.dart';
import 'package:mokrabela/screens/child/focus/focus_games_menu_screen.dart';
import 'package:mokrabela/screens/child/music/music_menu_screen.dart';
import 'package:mokrabela/screens/child/stories/story_menu_screen.dart';
import 'package:mokrabela/screens/child/protocol/missing_square_dashboard_screen.dart';
import 'package:mokrabela/theme/app_theme.dart';

import 'package:mokrabela/services/protocol_service.dart';
import 'package:sizer/sizer.dart';

/// Kids Protocol Screen - The Missing Square Protocol with 4 squares
class KidsProtocolScreen extends StatefulWidget {
  const KidsProtocolScreen({super.key});

  @override
  State<KidsProtocolScreen> createState() => _KidsProtocolScreenState();
}

class _KidsProtocolScreenState extends State<KidsProtocolScreen> {
  final AuthService _authService = AuthService();
  final ProtocolService _protocolService = ProtocolService();
  String _firstName = 'Friend';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = _authService.currentUser;
    if (user != null) {
      // Check and reset daily progress if needed
      await _protocolService.checkAndResetDailyProgress(user.uid);

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
                  ? AppLocalizations.of(context)!.friend
                  : firstName[0].toUpperCase() +
                        firstName.substring(1).toLowerCase();
            }
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _firstName = AppLocalizations.of(context)!.friend;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = _authService.currentUser;

    if (user == null) return const SizedBox.shrink();

    return StreamBuilder(
      stream: _protocolService.getEnrollmentStream(user.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final enrollment = snapshot.data!;
        final currentWeek = enrollment.calculateCurrentWeek(DateTime.now());

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(l10n, currentWeek),
              SizedBox(height: 3.h),
              _buildTimeline(context, l10n, currentWeek, enrollment),
              SizedBox(height: 14.h), // Space for bottom nav
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(AppLocalizations l10n, int currentWeek) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.helloLabel,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.deepBlue.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    _firstName,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.deepBlue,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  l10n.weekLabel(currentWeek),
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            l10n.letsStartProtocol,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.deepBlue.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(
    BuildContext context,
    AppLocalizations l10n,
    int currentWeek,
    dynamic enrollment,
  ) {
    return Column(
      children: List.generate(5, (index) {
        final weekIndex = index + 1;
        final isUnlocked = weekIndex <= currentWeek;
        final isNext = weekIndex == currentWeek;

        return _buildWeekStep(
          context,
          l10n,
          weekIndex: weekIndex,
          isUnlocked: isUnlocked,
          isNext: isNext,
          currentWeek: currentWeek,
        );
      }),
    );
  }

  Widget _buildWeekStep(
    BuildContext context,
    AppLocalizations l10n, {
    required int weekIndex,
    required bool isUnlocked,
    required bool isNext,
    required int currentWeek,
  }) {
    // Map of which squares unlock in which week - Strictly 5-Week Roadmap
    final Map<int, List<Widget>> weeklySquares = {
      1: [
        // Week 1 — Regulation & Safety
        _buildSquareShortCard(
          l10n.square2Title, // Breathing (Square 2)
          Icons.air_rounded,
          const [Color(0xFF667EEA), Color(0xFF764BA2)],
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelfRegulationScreen(),
            ),
          ),
        ),
        _buildSquareShortCard(
          l10n.square1Title, // Body Scan (Square 1)
          Icons.psychology_rounded,
          const [Color(0xFF4ECDC4), Color(0xFF44A08D)],
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelfAwarenessScreen(),
            ),
          ),
        ),
        _buildSquareShortCard(
          l10n.square3Title, // Daily Tasks (Square 3)
          Icons.task_alt_rounded,
          const [Color(0xFFFFE259), Color(0xFFFFA751)],
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DailyTasksScreen()),
          ),
        ),
      ],

      2: [
        // Week 2 — Focus & Emotional Control
        _buildSquareShortCard(
          l10n.focusQuest, // Focus Game
          Icons.games_rounded,
          const [Color(0xFFF6D365), Color(0xFFFDA085)],
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const FocusGamesMenuScreen(protocolSquare: 2),
            ),
          ),
        ),
        _buildSquareShortCard(
          l10n.mindfulStories, // Stories
          Icons.auto_stories_rounded,
          const [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StoryMenuScreen(protocolSquare: 2),
            ),
          ),
        ),
      ],

      3: [
        // Week 3 — Self-Regulation & Daily Structure
        _buildSquareShortCard(
          l10n.square3Title, // Daily Tasks
          Icons.task_alt_rounded,
          const [Color(0xFFFFE259), Color(0xFFFFA751)],
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DailyTasksScreen()),
          ),
        ),
        _buildSquareShortCard(
          l10n.square2Title, // Self-Regulation Screen
          Icons.air_rounded,
          const [Color(0xFF667EEA), Color(0xFF764BA2)],
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelfRegulationScreen(),
            ),
          ),
        ),
      ],
      4: [
        // Week 4 — Creative Calm & Expression
        _buildSquareShortCard(
          l10n.square4Title, // Psychological Calming (Drawing)
          Icons.self_improvement_rounded,
          const [Color(0xFFF093FB), Color(0xFFF5576C)],
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PsychologicalCalmingScreen(),
            ),
          ),
        ),
        _buildSquareShortCard(
          l10n.calmingRhythms, // Music
          Icons.music_note_rounded,
          const [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MusicMenuScreen()),
          ),
        ),
      ],
      5: [
        // Week 5 — Integration & Evaluation
        _buildSquareShortCard(
          l10n.finalDiscoveryDashboard, // Progress/Dashboard
          Icons.dashboard_customize_rounded,
          const [Color(0xFFFACD68), Color(0xFF0897B4)],
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MissingSquareDashboardScreen(),
            ),
          ),
        ),
      ],
    };

    final content = weeklySquares[weekIndex] ?? [];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vertical Line & Dot
          Column(
            children: [
              Container(
                width: 14.sp,
                height: 14.sp,
                decoration: BoxDecoration(
                  color: isUnlocked ? AppTheme.primary : Colors.grey[300],
                  shape: BoxShape.circle,
                  border: isNext
                      ? Border.all(
                          color: AppTheme.primary.withValues(alpha: 0.3),
                          width: 4,
                        )
                      : null,
                ),
              ),
              if (weekIndex < 5)
                Expanded(
                  child: Container(
                    width: 2,
                    color: weekIndex < currentWeek
                        ? AppTheme.primary
                        : Colors.grey[300],
                  ),
                ),
            ],
          ),
          SizedBox(width: 4.w),
          // Week Content
          Expanded(
            child: Opacity(
              opacity: isUnlocked ? 1.0 : 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${l10n.weekPrefix} $weekIndex",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: isUnlocked ? AppTheme.deepBlue : Colors.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  if (content.isNotEmpty) ...[
                    SizedBox(height: 1.5.h),
                    ...content.map(
                      (card) => Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: isUnlocked ? card : _buildLockedCard(card),
                      ),
                    ),
                  ] else
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Text(
                        l10n.continueTraining,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 11.sp,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareShortCard(
    String title,
    IconData icon,
    List<Color> gradient,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradient),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradient.first.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20.sp),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLockedCard(Widget card) {
    return AbsorbPointer(
      child: Stack(
        children: [
          card,
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
