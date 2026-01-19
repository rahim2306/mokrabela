import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/l10n/app_localizations.dart';

enum BreathingExerciseType {
  goldenBreath,
  butterflyBreath,
  oceanBreath,
  forestBreath,
  custom, // For Firestore exercises
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
  final Map<String, String>?
  localizedTitle; // {en: "...", ar: "...", fr: "..."}
  final Map<String, String>? localizedDescription;
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final bool isActive;
  final int order;

  const BreathingExercise({
    required this.type,
    required this.title,
    required this.description,
    required this.id,
    required this.durationSeconds,
    required this.defaultCycles,
    required this.gradient,
    required this.icon,
    this.localizedTitle,
    this.localizedDescription,
    this.inhaleSeconds = 4,
    this.holdSeconds = 4,
    this.exhaleSeconds = 4,
    this.isActive = true,
    this.order = 0,
  });

  /// Get localized title based on current locale
  String getTitle(String locale) {
    if (localizedTitle != null && localizedTitle!.containsKey(locale)) {
      return localizedTitle![locale]!;
    }
    return title; // Fallback
  }

  /// Get localized description based on current locale
  String getDescription(String locale) {
    if (localizedDescription != null &&
        localizedDescription!.containsKey(locale)) {
      return localizedDescription![locale]!;
    }
    return description; // Fallback
  }

  /// Create BreathingExercise from Firestore document
  factory BreathingExercise.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Parse gradient colors
    final gradientColors =
        (data['gradientColors'] as List<dynamic>?)
            ?.map(
              (hex) =>
                  Color(int.parse(hex.toString().replaceFirst('#', '0xFF'))),
            )
            .toList() ??
        [const Color(0xFF4ECDC4), const Color(0xFF44A08D)];

    // Parse icon
    final iconName = data['icon'] as String? ?? 'air';
    final icon = _getIconFromName(iconName);

    // Calculate duration
    final inhale = data['inhaleSeconds'] as int? ?? 4;
    final hold = data['holdSeconds'] as int? ?? 4;
    final exhale = data['exhaleSeconds'] as int? ?? 4;
    final duration = inhale + hold + exhale;

    return BreathingExercise(
      type: BreathingExerciseType.custom,
      title: data['id'] ?? doc.id,
      description: data['id'] ?? doc.id,
      id: doc.id,
      durationSeconds: duration,
      defaultCycles: data['cycles'] as int? ?? 4,
      gradient: gradientColors,
      icon: icon,
      localizedTitle: data['title'] != null
          ? Map<String, String>.from(data['title'])
          : null,
      localizedDescription: data['description'] != null
          ? Map<String, String>.from(data['description'])
          : null,
      inhaleSeconds: inhale,
      holdSeconds: hold,
      exhaleSeconds: exhale,
      isActive: data['isActive'] ?? true,
      order: data['order'] ?? 0,
    );
  }

  static IconData _getIconFromName(String name) {
    switch (name.toLowerCase()) {
      case 'wb_sunny':
      case 'sunny':
        return Icons.wb_sunny;
      case 'flutter_dash':
      case 'butterfly':
        return Icons.flutter_dash;
      case 'waves':
      case 'ocean':
        return Icons.waves;
      case 'forest':
      case 'park':
        return Icons.park;
      case 'air':
      default:
        return Icons.air;
    }
  }

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
