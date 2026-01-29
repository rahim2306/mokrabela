import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:sizer/sizer.dart';

class MathPuzzleGame extends StatefulWidget {
  final AuthService? authService;
  final SessionService? sessionService;

  final int? protocolSquare;

  const MathPuzzleGame({
    super.key,
    this.authService,
    this.sessionService,
    this.protocolSquare,
  });

  @override
  State<MathPuzzleGame> createState() => _MathPuzzleGameState();
}

class _MathPuzzleGameState extends State<MathPuzzleGame> {
  final Random _random = Random();
  late final SessionService _sessionService;
  late final AuthService _authService;
  late Timer _timer;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _sessionService = widget.sessionService ?? SessionService();
    _authService = widget.authService ?? AuthService();
  }

  // Game State
  int _score = 0;
  int _timeLeft = 60; // 60 seconds round
  bool _isPlaying = false;
  bool _isGameOver = false;

  // Current Question
  String _question = "";
  List<int> _options = [];
  int _correctAnswer = 0;

  @override
  void dispose() {
    if (_isPlaying) _timer.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = 60;
      _isPlaying = true;
      _isGameOver = false;
      _startTime = DateTime.now();
    });
    _generateQuestion();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _endGame();
      }
    });
  }

  Future<void> _endGame() async {
    _timer.cancel();
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
        exerciseName: 'Math Puzzle',
        exerciseType: 'math_game',
        startTime: _startTime!,
        endTime: endTime,
        completed: true,
        protocolSquare: widget.protocolSquare ?? 5,
        exerciseData: {'score': _score},
        context: context,
      );
    }
  }

  void _generateQuestion() {
    // Generate simple arithmetic (Addition/Subtraction)
    // Difficulty can scale with score if needed
    final int a = _random.nextInt(20) + 1; // 1-20
    final int b = _random.nextInt(20) + 1; // 1-20
    final bool isAddition = _random.nextBool();

    if (isAddition) {
      _question = "$a + $b = ?";
      _correctAnswer = a + b;
    } else {
      // Ensure result is positive for simplicity
      final maxVal = max(a, b);
      final minVal = min(a, b);
      _question = "$maxVal - $minVal = ?";
      _correctAnswer = maxVal - minVal;
    }

    _generateOptions();
  }

  void _generateOptions() {
    _options = [_correctAnswer];
    while (_options.length < 4) {
      // Generate distractors close to the answer
      final offset = _random.nextInt(10) - 5; // -5 to +5
      final option = _correctAnswer + offset;
      if (option >= 0 && !_options.contains(option)) {
        _options.add(option);
      }
    }
    _options.shuffle();
  }

  void _checkAnswer(int selected) {
    if (!_isPlaying) return;

    if (selected == _correctAnswer) {
      setState(() {
        _score += 10;
        // visual feedback could go here
      });
      _generateQuestion();
    } else {
      // Option: Penalize time or score? Let's just shake or do nothing for now
      // Simple feedback: generated new question on wrong answer too?
      // Or make them retry. Let's regenerate to keep flow.
      setState(() {
        _score = max(0, _score - 5);
      });
      _generateQuestion();
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
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: AppBar(
        title: Text(
          "Math Puzzle",
          style: GoogleFonts.spaceGrotesk(
            color: AppTheme.deepBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: const SizedBox(), // Disable back button during game
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Text(
                "$_timeLeft s",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: _timeLeft < 10 ? Colors.red : AppTheme.deepBlue,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            // Score Display
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Score: $_score",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            // Question Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                _question,
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.deepBlue,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            // Options Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 4.w,
                  childAspectRatio: 1.3,
                ),
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  return _buildOptionBtn(_options[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionBtn(int value) {
    return GestureDetector(
      onTap: () => _checkAnswer(value),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFF9A9E), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9A9E).withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "$value",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.deepBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
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
              Icons.calculate_rounded,
              size: 50.sp,
              color: const Color(0xFFFF9A9E),
            ),
            SizedBox(height: 2.h),
            Text(
              "Math Puzzle",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9A9E),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "START GAME",
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
      backgroundColor: const Color(0xFFFFF5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Time's Up!",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Final Score: $_score",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
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
                  label: const Text("Play Again"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9A9E),
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
