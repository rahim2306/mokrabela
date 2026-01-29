import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:sizer/sizer.dart';

class MemorySequenceGame extends StatefulWidget {
  final AuthService? authService;
  final SessionService? sessionService;

  final int? protocolSquare;

  const MemorySequenceGame({
    super.key,
    this.authService,
    this.sessionService,
    this.protocolSquare,
  });

  @override
  State<MemorySequenceGame> createState() => _MemorySequenceGameState();
}

class _MemorySequenceGameState extends State<MemorySequenceGame> {
  final Random _random = Random();
  late final SessionService _sessionService;
  late final AuthService _authService;

  // Game State
  List<int> _sequence =
      []; // 0: Red/Circle, 1: Blue/Square, 2: Green/Triangle, 3: Yellow/Star
  int _currentIndex = 0; // Current index player needs to tap
  bool _isShowingSequence = false;
  bool _isPlaying = false;
  bool _isGameOver = false;
  int _score = 0;
  int _highScore = 0; // Local high score for this session
  int _activeHighlightIndex = -1; // Which button is currently lit up
  DateTime? _startTime;

  // Visual Assets
  final List<Color> _colors = [
    const Color(0xFFFF5252), // Red
    const Color(0xFF448AFF), // Blue
    const Color(0xFF69F0AE), // Green
    const Color(0xFFFFD740), // Yellow
  ];

  final List<IconData> _icons = [
    Icons.circle,
    Icons.square_rounded,
    Icons.change_history_rounded,
    Icons.star_rounded,
  ];

  @override
  void dispose() {
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _sequence = [];
      _score = 0;
      _isPlaying = true;
      _isGameOver = false;
      _startTime = DateTime.now();
      _activeHighlightIndex = -1;
    });
    _nextRound();
  }

  void _nextRound() async {
    // Add one new random step
    setState(() {
      _sequence.add(_random.nextInt(4));
      _currentIndex = 0;
      _isShowingSequence = true;
    });

    // Play back the sequence
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Wait a bit before starting

    for (int step in _sequence) {
      if (!mounted) return;

      setState(() => _activeHighlightIndex = step);
      // Play sound here ideally
      await Future.delayed(
        const Duration(milliseconds: 600),
      ); // Light up duration

      setState(() => _activeHighlightIndex = -1);
      await Future.delayed(
        const Duration(milliseconds: 200),
      ); // Gap between steps
    }

    if (mounted) {
      setState(() {
        _isShowingSequence = false;
      });
    }
  }

  void _handleTap(int index) async {
    if (!_isPlaying || _isShowingSequence) return;

    // Visual feedback for tap
    setState(() => _activeHighlightIndex = index);
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) setState(() => _activeHighlightIndex = -1);

    if (index == _sequence[_currentIndex]) {
      // Correct tap
      _currentIndex++;
      if (_currentIndex >= _sequence.length) {
        // Completed the sequence
        setState(() {
          _score++;
          if (_score > _highScore) _highScore = _score;
        });
        // Feedback logic (sound/checkmark) could go here

        // Next round
        _nextRound();
      }
    } else {
      // Wrong tap - Game Over
      _endGame();
    }
  }

  Future<void> _endGame() async {
    setState(() {
      _isPlaying = false;
      _isGameOver = true;
    });

    final user = _authService.currentUser;
    if (user != null && _startTime != null) {
      final endTime = DateTime.now();
      await _sessionService.saveSession(
        childId: user.uid,
        type: 'focus',
        exerciseName: 'Memory Sequence',
        exerciseType: 'memory_game',
        startTime: _startTime!,
        endTime: endTime,
        completed: true,
        protocolSquare: widget.protocolSquare ?? 5,
        exerciseData: {
          'score': _score, // Sessions score is round number
          'maxSequence': _sequence.length,
        },
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPlaying && !_isGameOver) {
      return _buildStartScreen();
    } else if (_isGameOver) {
      return _buildGameOverScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Memory Sequence",
          style: GoogleFonts.spaceGrotesk(
            color: AppTheme.deepBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Text(
                "Round: ${_sequence.length}",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.deepBlue,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h),
          Text(
            _isShowingSequence ? "Watch Closely..." : "Your Turn!",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: _isShowingSequence
                  ? AppTheme.primary
                  : const Color(0xFF4ECDC4),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 5.w,
                mainAxisSpacing: 5.w,
                children: List.generate(4, (index) => _buildGameButton(index)),
              ),
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  Widget _buildGameButton(int index) {
    final bool isActive = _activeHighlightIndex == index;

    return GestureDetector(
      onTapDown: (_) {
        if (!_isShowingSequence && _isPlaying) {
          // Instant feedback
        }
      },
      onTap: () => _handleTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive
              ? _colors[index]
              : _colors[index].withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isActive ? Colors.white : _colors[index],
            width: isActive ? 4 : 2,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: _colors[index].withValues(alpha: 0.6),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Icon(
            _icons[index],
            size: 40.sp,
            color: isActive ? Colors.white : _colors[index],
          ),
        ),
      ),
    );
  }

  Widget _buildStartScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.psychology_rounded,
              size: 60.sp,
              color: AppTheme.primary,
            ),
            SizedBox(height: 3.h),
            Text(
              "Memory Training",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Remember the sequence\nand repeat it!",
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 5.h),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "START",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOverScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sequence Broken!",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Score: $_score",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 30.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Exit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.5.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                ElevatedButton.icon(
                  onPressed: _startGame,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Try Again"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.5.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
