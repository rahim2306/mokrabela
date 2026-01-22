import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/breathing_exercise_model.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class BreathingSessionScreen extends StatefulWidget {
  final BreathingExercise exercise;
  final VoidCallback? onComplete;
  final int? protocolSquare;

  const BreathingSessionScreen({
    super.key,
    required this.exercise,
    this.onComplete,
    this.protocolSquare,
  });

  @override
  State<BreathingSessionScreen> createState() => _BreathingSessionScreenState();
}

class _BreathingSessionScreenState extends State<BreathingSessionScreen>
    with SingleTickerProviderStateMixin {
  final SessionService _sessionService = SessionService();
  final AuthService _authService = AuthService();

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  int _currentCycle = 0;
  BreathPhase _currentPhase = BreathPhase.inhale;
  Timer? _phaseTimer;
  bool _isCompleted = false;
  late DateTime _sessionStartTime;

  @override
  void initState() {
    super.initState();
    _sessionStartTime = DateTime.now();
    _setupAnimation();
    _startBreathingCycle();
  }

  void _setupAnimation() {
    final cycleDuration = Duration(seconds: widget.exercise.durationSeconds);
    _controller = AnimationController(vsync: this, duration: cycleDuration);

    _scaleAnimation = TweenSequence<double>([
      // Inhale - 50% of cycle
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.5,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      // Exhale - 50% of cycle
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.5,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentCycle++;
          if (_currentCycle >= widget.exercise.defaultCycles) {
            _completeSession();
          } else {
            _controller.forward(from: 0);
          }
        });
      }
    });
  }

  void _startBreathingCycle() {
    _controller.forward(from: 0);
    _updatePhases();
  }

  void _updatePhases() {
    final cycleDuration = widget.exercise.durationSeconds * 1000;
    final inhaleDuration = (cycleDuration * 0.5).toInt();
    final exhaleDuration = (cycleDuration * 0.5).toInt();

    // Inhale phase
    setState(() => _currentPhase = BreathPhase.inhale);

    _phaseTimer = Timer(Duration(milliseconds: inhaleDuration), () {
      if (!mounted) return;
      setState(() => _currentPhase = BreathPhase.exhale);

      _phaseTimer = Timer(Duration(milliseconds: exhaleDuration), () {
        if (!mounted) return;
        if (_currentCycle < widget.exercise.defaultCycles - 1) {
          _updatePhases();
        }
      });
    });
  }

  void _completeSession() async {
    setState(() => _isCompleted = true);
    _phaseTimer?.cancel();

    // Wait for completion animation
    await Future.delayed(const Duration(seconds: 2));

    // Save session and show achievement dialogs
    final user = _authService.currentUser;
    if (user != null && mounted) {
      try {
        await _sessionService.saveSession(
          childId: user.uid,
          type: 'breathing',
          exerciseName: widget.exercise.title,
          exerciseType: widget.exercise.id,
          protocolSquare: widget.protocolSquare,
          startTime: _sessionStartTime,
          endTime: DateTime.now(),
          completed: true,
          exerciseData: {'breathingCycles': _currentCycle},
          context: context,
        );
      } catch (error) {
        print('Error saving session: $error');
      }
    }

    // Close screen after achievements
    if (mounted) {
      widget.onComplete?.call();
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _phaseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          // Calculate saturation based on circle scale (0.5 to 1.0 maps to 0.1 to 0.3)
          final saturation = 0.1 + (_scaleAnimation.value - 0.5) * 0.4;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.exercise.gradient.first.withValues(alpha: saturation),
                  widget.exercise.gradient.last.withValues(
                    alpha: saturation * 0.5,
                  ),
                  const Color(0xFFFAFAFA),
                ],
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
                        Container(
                          decoration: BoxDecoration(
                            color: widget.exercise.gradient.first.withValues(
                              alpha: 0.15,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: widget.exercise.gradient.first,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.exercise.title,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.deepBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 48), // Balance the close button
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Main breathing circle with dynamic radial gradient
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            widget.exercise.gradient.first,
                            widget.exercise.gradient.last,
                            widget.exercise.gradient.last.withValues(
                              // Map scale 0.5->1.0 to alpha 0.0->1.0
                              alpha: (_scaleAnimation.value - 0.5) * 2.0,
                            ),
                            widget.exercise.gradient.last.withValues(
                              alpha: 0.0,
                            ),
                          ],
                          stops: [
                            0.0,
                            0.3 +
                                (_scaleAnimation.value *
                                    0.2), // Expands from 0.3 to 0.5
                            0.6 +
                                (_scaleAnimation.value *
                                    0.2), // Expands from 0.6 to 0.8
                            1.0,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.exercise.gradient.first.withValues(
                              // Map scale 0.5->1.0 to alpha 0.0->0.5
                              alpha: (_scaleAnimation.value - 0.5) * 1.0,
                            ),
                            // Map scale 0.5->1.0 to blur 0->50
                            blurRadius: (_scaleAnimation.value - 0.5) * 100,
                            // Map scale 0.5->1.0 to spread 0->15
                            spreadRadius: (_scaleAnimation.value - 0.5) * 30,
                          ),
                          BoxShadow(
                            color: widget.exercise.gradient.last.withValues(
                              // Map scale 0.5->1.0 to alpha 0.0->0.3
                              alpha: (_scaleAnimation.value - 0.5) * 0.6,
                            ),
                            // Map scale 0.5->1.0 to blur 0->30
                            blurRadius: (_scaleAnimation.value - 0.5) * 60,
                            // Map scale 0.5->1.0 to spread 0->5
                            spreadRadius: (_scaleAnimation.value - 0.5) * 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: _isCompleted
                            ? Icon(
                                Icons.check_circle,
                                size: 30.w,
                                color: Colors.white,
                              )
                            : Icon(
                                widget.exercise.icon,
                                size: 20.w,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Phase indicator
                  if (!_isCompleted)
                    Text(
                      _getPhaseText(l10n),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.deepBlue,
                      ),
                    ),

                  if (_isCompleted)
                    Text(
                      '🎉 ${l10n.breathingExercisesTitle} ✨',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.deepBlue,
                      ),
                    ),

                  const Spacer(),

                  // Cycle counter
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    margin: EdgeInsets.only(bottom: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: widget.exercise.gradient,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: widget.exercise.gradient.first.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      _isCompleted
                          ? 'Complete!'
                          : 'Cycle ${_currentCycle + 1}/${widget.exercise.defaultCycles}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getPhaseText(AppLocalizations l10n) {
    switch (_currentPhase) {
      case BreathPhase.inhale:
        return 'Breathe In'; // TODO: Localize
      case BreathPhase.exhale:
        return 'Breathe Out';
    }
  }
}

enum BreathPhase { inhale, exhale }
