import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Achievement rarity levels
enum AchievementRarity { common, rare, epic, legendary }

/// Achievement categories
enum AchievementCategory { exercise, streaks, calm, milestones, special }

/// Achievement model for tracking user progress and unlocks
class Achievement {
  final String id;
  final String titleKey; // Localization key
  final String descriptionKey; // Localization key
  final AchievementCategory category;
  final IconData icon;
  final List<Color> gradientColors;
  final int targetValue;
  final int currentValue;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int points;
  final AchievementRarity rarity;

  Achievement({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.category,
    required this.icon,
    required this.gradientColors,
    required this.targetValue,
    this.currentValue = 0,
    this.isUnlocked = false,
    this.unlockedAt,
    required this.points,
    required this.rarity,
  });

  /// Calculate progress as percentage (0.0 to 1.0)
  double get progress =>
      targetValue > 0 ? (currentValue / targetValue).clamp(0.0, 1.0) : 0.0;

  /// Check if achievement is completed but not yet unlocked
  bool get isCompleted => currentValue >= targetValue;

  /// Copy with updated values
  Achievement copyWith({
    int? currentValue,
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id,
      titleKey: titleKey,
      descriptionKey: descriptionKey,
      category: category,
      icon: icon,
      gradientColors: gradientColors,
      targetValue: targetValue,
      currentValue: currentValue ?? this.currentValue,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      points: points,
      rarity: rarity,
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'currentValue': currentValue,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'progress': progress,
    };
  }

  /// Create from Firestore map
  static Achievement fromFirestore(
    Map<String, dynamic> data,
    Achievement template,
  ) {
    DateTime? unlockedAt;
    if (data['unlockedAt'] != null) {
      final unlockedAtData = data['unlockedAt'];
      if (unlockedAtData is Timestamp) {
        unlockedAt = unlockedAtData.toDate();
      } else if (unlockedAtData is String) {
        unlockedAt = DateTime.parse(unlockedAtData);
      }
    }

    return template.copyWith(
      currentValue: data['currentValue'] ?? 0,
      isUnlocked: data['isUnlocked'] ?? false,
      unlockedAt: unlockedAt,
    );
  }

  /// Get gradient colors based on rarity
  static List<Color> getGradientForRarity(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return [const Color(0xFF4ECDC4), const Color(0xFF44A08D)]; // Teal
      case AchievementRarity.rare:
        return [
          const Color(0xFF667EEA),
          const Color(0xFF764BA2),
        ]; // Blue-Purple
      case AchievementRarity.epic:
        return [const Color(0xFFFF6B6B), const Color(0xFFEE5A24)]; // Red-Orange
      case AchievementRarity.legendary:
        return [
          const Color(0xFFFFD700),
          const Color(0xFFFF8C00),
        ]; // Gold-Orange
    }
  }

  /// Get points based on rarity
  static int getPointsForRarity(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return 25;
      case AchievementRarity.rare:
        return 100;
      case AchievementRarity.epic:
        return 300;
      case AchievementRarity.legendary:
        return 750;
    }
  }
}
