import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/games/flip_card_widget.dart';
import 'package:mokrabela/controllers/memory_game_controller.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class MemoryGameScreen extends StatefulWidget {
  final int? protocolSquare;
  const MemoryGameScreen({super.key, this.protocolSquare});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final SessionService _sessionService = SessionService();
  final AuthService _authService = AuthService();
  late MemoryGameController _controller;
  late DateTime _sessionStartTime;

  @override
  void initState() {
    super.initState();
    _sessionStartTime = DateTime.now();
    _controller = MemoryGameController();
    _controller.addListener(_onGameStateChanged);
  }

  void _onGameStateChanged() async {
    if (_controller.isGameComplete) {
      // Save session and show achievement dialogs
      final user = _authService.currentUser;
      if (user != null && mounted) {
        try {
          await _sessionService.saveSession(
            childId: user.uid,
            type: 'focus',
            exerciseName: 'Memory Flip',
            exerciseType: 'memory_flip',
            protocolSquare: widget.protocolSquare,
            startTime: _sessionStartTime,
            endTime: DateTime.now(),
            completed: true,
            exerciseData: {
              'moves': _controller.moves,
              'timeSeconds': _controller.elapsedSeconds,
            },
            context: context,
          );
        } catch (error) {
          print('Error saving session: $error');
        }
      }

      _showCompletionDialog();
    }
    setState(() {});
  }

  void _showCompletionDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          l10n.gameComplete,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: AppTheme.deepBlue,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emoji_events,
              size: 20.w,
              color: const Color(0xFFFFD700),
            ),
            SizedBox(height: 2.h),
            Text(
              l10n.wellDone,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 2.h),
            _buildStatRow(Icons.timer, l10n.time, _controller.formattedTime),
            SizedBox(height: 1.h),
            _buildStatRow(Icons.touch_app, l10n.moves, '${_controller.moves}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.initializeGame();
            },
            child: Text(
              l10n.playAgain,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.deepBlue,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.deepBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Exit',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppTheme.deepBlue, size: 6.w),
        SizedBox(width: 2.w),
        Text(
          '$label: ',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.deepBlue.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: AppTheme.deepBlue,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onGameStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAFAFA), Color(0xFFE8F5E9), Color(0xFFFAFAFA)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(2.h),
                child: Row(
                  children: [
                    // Close button
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.deepBlue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: AppTheme.deepBlue),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Memory Flip',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.deepBlue,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildHeaderStat(
                                Icons.timer,
                                _controller.formattedTime,
                              ),
                              SizedBox(width: 4.w),
                              _buildHeaderStat(
                                Icons.touch_app,
                                '${_controller.moves} ${l10n.moves}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 48), // Balance close button
                  ],
                ),
              ),

              // Game Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2.w,
                      mainAxisSpacing: 2.w,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _controller.cards.length,
                    itemBuilder: (context, index) {
                      final card = _controller.cards[index];
                      return FlipCardWidget(
                        card: card,
                        onTap: () => _controller.flipCard(card),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderStat(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.deepBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.deepBlue, size: 5.w),
          SizedBox(width: 1.w),
          Text(
            text,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.deepBlue,
            ),
          ),
        ],
      ),
    );
  }
}
