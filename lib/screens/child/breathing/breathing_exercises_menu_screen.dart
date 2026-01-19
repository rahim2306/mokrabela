import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/cards/breathing_exercise_card.dart';
import 'package:mokrabela/components/cards/sticky_info_card.dart';
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
  List<BreathingExercise>?
  _cachedExercises; // Cache exercises to prevent rebuilds

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
          child: Stack(
            children: [
              // StreamBuilder for exercises
              StreamBuilder<List<BreathingExercise>>(
                stream: _breathingService.getExercises(l10n),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      _cachedExercises == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError && _cachedExercises == null) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  // Update cache when new data arrives
                  if (snapshot.hasData) {
                    _cachedExercises = snapshot.data;
                  }

                  final exercises =
                      _cachedExercises ??
                      BreathingExercise.getAllExercises(l10n);

                  // Scrollable grid of exercises
                  return GridView.builder(
                    padding: EdgeInsets.fromLTRB(
                      4.w,
                      2.h,
                      4.w,
                      25.h, // Fixed padding for card
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 3.h,
                      childAspectRatio: 0.86,
                    ),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
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
                    },
                  );
                },
              ),

              // Sticky info card at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: StickyInfoCard(
                  title: l10n.whyBreatheTitle,
                  description: l10n.whyBreatheDesc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
