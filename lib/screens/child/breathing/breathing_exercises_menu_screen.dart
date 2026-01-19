import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/cards/breathing_exercise_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/breathing_exercise_model.dart';
import 'package:mokrabela/screens/child/breathing/breathing_session_screen.dart';
import 'package:mokrabela/services/breathing_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class BreathingExercisesMenuScreen extends StatefulWidget {
  const BreathingExercisesMenuScreen({super.key});

  @override
  State<BreathingExercisesMenuScreen> createState() =>
      _BreathingExercisesMenuScreenState();
}

class _BreathingExercisesMenuScreenState
    extends State<BreathingExercisesMenuScreen> {
  final BreathingService _breathingService = BreathingService();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.breathingExercisesTitle,
          style: GoogleFonts.spaceGrotesk(
            color: AppTheme.deepBlue,
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppTheme.deepBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAFAFA),
              Color.fromARGB(255, 187, 222, 230),
              Color(0xFFFAFAFA),
            ],
            stops: [0.0, 0.1, 0.9],
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<List<BreathingExercise>>(
            stream: _breathingService.getExercises(l10n),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final exercises =
                  snapshot.data ?? BreathingExercise.getAllExercises(l10n);

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Grid of Exercises
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.w,
                        mainAxisSpacing: 3.h,
                        childAspectRatio: 0.86,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final exercise = exercises[index];
                        return BreathingExerciseCard(
                          exercise: exercise,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BreathingSessionScreen(
                                  exercise: exercise,
                                  onComplete: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '✨ ${exercise.title} Complete!',
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }, childCount: exercises.length),
                    ),
                  ),
                  // Info Card
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.h),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(3.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFFDFBF7), // Off-white / Cream
                              const Color(0xFFF4F8F9), // Very light cool grey
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.deepBlue.withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.6),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(1.5.w),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFFFE082,
                                    ).withValues(alpha: 0.2), // Light Amber
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.tips_and_updates,
                                    color: const Color(0xFFFFA000), // Amber
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    l10n.whyBreatheTitle,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.deepBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              l10n.whyBreatheDesc,
                              style: TextStyle(
                                fontSize: 12.sp,
                                height: 1.6,
                                color: AppTheme.deepBlue.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
