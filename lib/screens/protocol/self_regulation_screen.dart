import 'package:flutter/material.dart';
import 'package:mokrabela/screens/child/breathing/breathing_session_screen.dart';
import 'package:mokrabela/models/breathing_exercise_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:mokrabela/services/session_service.dart';

class SelfRegulationScreen extends StatefulWidget {
  const SelfRegulationScreen({super.key});

  @override
  State<SelfRegulationScreen> createState() => _SelfRegulationScreenState();
}

class _SelfRegulationScreenState extends State<SelfRegulationScreen> {
  int _currentStopStep = 0;
  final ProtocolService _protocolService = ProtocolService();
  final AuthService _authService = AuthService();
  final SessionService _sessionService = SessionService();
  bool _isSaving = false;
  late DateTime _screenStartTime;

  @override
  void initState() {
    super.initState();
    _screenStartTime = DateTime.now();
  }

  Future<void> _completeSession() async {
    setState(() => _isSaving = true);
    try {
      final user = _authService.currentUser;
      if (user != null) {
        // Record session (includes biometrics)
        await _sessionService.saveSession(
          childId: user.uid,
          type: 'breathing',
          exerciseName: 'Self Regulation',
          exerciseType: 'stop_technique',
          protocolSquare: 2,
          startTime: _screenStartTime,
          endTime: DateTime.now(),
          completed: true,
          context: context,
        );

        await _protocolService.updateProtocolProgress(user.uid, 2);
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667EEA), // Indigo
              Color(0xFF764BA2), // Deep Purple
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                child: Hero(
                  tag: 'regulation_card',
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          l10n.square2Title,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content Area
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.stopTechnique,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.deepBlue,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // STOP Stepper
                        _buildStopStepper(l10n),

                        SizedBox(height: 4.h),

                        // Additional Tools Section
                        Text(
                          l10n.breatheWithMe,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.deepBlue,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        _buildSpecialToolCard(
                          l10n.goldenBreathTitle,
                          l10n.goldenBreathDesc,
                          Icons.air_rounded,
                          const Color(0xFF4ECDC4),
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BreathingSessionScreen(
                                exercise: BreathingExercise(
                                  id: 'star-breath',
                                  type: BreathingExerciseType.custom,
                                  title: l10n.goldenBreathTitle,
                                  description: l10n.goldenBreathDesc,
                                  durationSeconds: 12,
                                  defaultCycles: 4,
                                  inhaleSeconds: 4,
                                  holdSeconds: 4,
                                  exhaleSeconds: 4,
                                  gradient: const [
                                    Color(0xFF4ECDC4),
                                    Color(0xFF44A08D),
                                  ],
                                  icon: Icons.star_rounded,
                                ),
                                protocolSquare: 2,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 6.h),

                        // Finish Button
                        Center(
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : _completeSession,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF764BA2),
                              minimumSize: Size(double.infinity, 7.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: _isSaving
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    l10n.feelingCooler,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStopStepper(AppLocalizations l10n) {
    final steps = [
      {
        'title': l10n.stopStep1Title,
        'desc': l10n.stopStep1Desc,
        'icon': Icons.back_hand_rounded,
      },
      {
        'title': l10n.stopStep2Title,
        'desc': l10n.stopStep2Desc,
        'icon': Icons.air_rounded,
      },
      {
        'title': l10n.stopStep3Title,
        'desc': l10n.stopStep3Desc,
        'icon': Icons.visibility_rounded,
      },
      {
        'title': l10n.stopStep4Title,
        'desc': l10n.stopStep4Desc,
        'icon': Icons.play_arrow_rounded,
      },
    ];

    return Column(
      children: List.generate(steps.length, (index) {
        bool isActive = _currentStopStep == index;
        bool isDone = _currentStopStep > index;

        return IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _currentStopStep = index),
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: isDone
                            ? Colors.green
                            : (isActive
                                  ? const Color(0xFF764BA2)
                                  : Colors.grey[200]),
                        shape: BoxShape.circle,
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF764BA2,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        isDone
                            ? Icons.check
                            : (steps[index]['icon'] as IconData),
                        color: isDone || isActive
                            ? Colors.white
                            : Colors.grey[500],
                        size: 14.sp,
                      ),
                    ),
                  ),
                  if (index < steps.length - 1)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: isDone ? Colors.green : Colors.grey[200],
                      ),
                    ),
                ],
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentStopStep = index),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF764BA2).withValues(alpha: 0.05)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isActive
                            ? const Color(0xFF764BA2).withValues(alpha: 0.2)
                            : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[index]['title'] as String,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: isActive
                                ? const Color(0xFF764BA2)
                                : AppTheme.deepBlue,
                          ),
                        ),
                        if (isActive) ...[
                          SizedBox(height: 0.5.h),
                          Text(
                            steps[index]['desc'] as String,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSpecialToolCard(
    String title,
    String desc,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: 80.w, // Calculated to match card content area
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24.sp),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: AppTheme.deepBlue,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        desc,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.play_arrow_rounded, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
