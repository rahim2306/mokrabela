import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';

enum BreathingExerciseType {
  goldenBreath,
  butterflyBreath,
  oceanBreath,
  forestBreath,
}

class BreathingExercise {
  final BreathingExerciseType type;
  final String title;
  final String description;
  final String id;
  final int durationSeconds; // Duration per cycle
  final int defaultCycles;
  final List<Color> gradient;
  final IconData icon;

  const BreathingExercise({
    required this.type,
    required this.title,
    required this.description,
    required this.id,
    required this.durationSeconds,
    required this.defaultCycles,
    required this.gradient,
    required this.icon,
  });

  static List<BreathingExercise> getAllExercises(AppLocalizations l10n) {
    return [
      BreathingExercise(
        type: BreathingExerciseType.goldenBreath,
        title: l10n.goldenBreathTitle,
        description: l10n.goldenBreathDesc,
        id: 'golden_breath',
        durationSeconds: 6,
        defaultCycles: 4,
        gradient: const [Color(0xFFFFD700), Color(0xFFFFA500)], // Gold/Orange
        icon: Icons.wb_sunny,
      ),
      BreathingExercise(
        type: BreathingExerciseType.butterflyBreath,
        title: l10n.butterflyBreathTitle,
        description: l10n.butterflyBreathDesc,
        id: 'butterfly_breath',
        durationSeconds: 10,
        defaultCycles: 6,
        gradient: const [Color(0xFFE0C3FC), Color(0xFF8EC5FC)], // Lavender/Blue
        icon: Icons.filter_vintage, // Butterfly-ish
      ),
      BreathingExercise(
        type: BreathingExerciseType.oceanBreath,
        title: l10n.oceanBreathTitle,
        description: l10n.oceanBreathDesc,
        id: 'ocean_breath',
        durationSeconds: 8,
        defaultCycles: 5,
        gradient: const [Color(0xFF4FACFE), Color(0xFF00F2FE)], // Ocean Blue
        icon: Icons.waves,
      ),
      BreathingExercise(
        type: BreathingExerciseType.forestBreath,
        title: l10n.forestBreathTitle,
        description: l10n.forestBreathDesc,
        id: 'forest_breath',
        durationSeconds: 7,
        defaultCycles: 5,
        gradient: const [Color(0xFF43E97B), Color(0xFF38F9D7)], // Forest Green
        icon: Icons.forest,
      ),
    ];
  }
}
