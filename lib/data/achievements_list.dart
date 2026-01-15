import 'package:flutter/material.dart';
import 'package:mokrabela/models/achievement_model.dart';

/// Predefined list of all achievements in the app
class AchievementsList {
  static List<Achievement> getAllAchievements() {
    return [
      // ==================== EXERCISE ACHIEVEMENTS ====================
      Achievement(
        id: 'breathing_first',
        titleKey: 'achFirstBreathing',
        descriptionKey: 'achFirstBreathingDesc',
        category: AchievementCategory.exercise,
        icon: Icons.air,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 1,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'breathing_5',
        titleKey: 'achBreathing5',
        descriptionKey: 'achBreathing5Desc',
        category: AchievementCategory.exercise,
        icon: Icons.air,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 5,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'breathing_10',
        titleKey: 'achBreathing10',
        descriptionKey: 'achBreathing10Desc',
        category: AchievementCategory.exercise,
        icon: Icons.air,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 10,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
      Achievement(
        id: 'breathing_master',
        titleKey: 'achBreathingMaster',
        descriptionKey: 'achBreathingMasterDesc',
        category: AchievementCategory.exercise,
        icon: Icons.air,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 30,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'focus_first',
        titleKey: 'achFirstFocus',
        descriptionKey: 'achFirstFocusDesc',
        category: AchievementCategory.exercise,
        icon: Icons.track_changes,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 1,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'focus_champion',
        titleKey: 'achFocusChampion',
        descriptionKey: 'achFocusChampionDesc',
        category: AchievementCategory.exercise,
        icon: Icons.track_changes,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 20,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'music_beginner',
        titleKey: 'achMusicBeginner',
        descriptionKey: 'achMusicBeginnerDesc',
        category: AchievementCategory.exercise,
        icon: Icons.music_note,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 5,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'music_expert',
        titleKey: 'achMusicExpert',
        descriptionKey: 'achMusicExpertDesc',
        category: AchievementCategory.exercise,
        icon: Icons.music_note,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 25,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'story_starter',
        titleKey: 'achStoryStarter',
        descriptionKey: 'achStoryStarterDesc',
        category: AchievementCategory.exercise,
        icon: Icons.menu_book,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 3,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'story_master',
        titleKey: 'achStoryMaster',
        descriptionKey: 'achStoryMasterDesc',
        category: AchievementCategory.exercise,
        icon: Icons.menu_book,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 15,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),

      // ==================== STREAK ACHIEVEMENTS ====================
      Achievement(
        id: 'streak_3',
        titleKey: 'achStreak3',
        descriptionKey: 'achStreak3Desc',
        category: AchievementCategory.streaks,
        icon: Icons.local_fire_department,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 3,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'streak_7',
        titleKey: 'achStreak7',
        descriptionKey: 'achStreak7Desc',
        category: AchievementCategory.streaks,
        icon: Icons.local_fire_department,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 7,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
      Achievement(
        id: 'streak_14',
        titleKey: 'achStreak14',
        descriptionKey: 'achStreak14Desc',
        category: AchievementCategory.streaks,
        icon: Icons.local_fire_department,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 14,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'streak_30',
        titleKey: 'achStreak30',
        descriptionKey: 'achStreak30Desc',
        category: AchievementCategory.streaks,
        icon: Icons.local_fire_department,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.legendary,
        ),
        targetValue: 30,
        points: Achievement.getPointsForRarity(AchievementRarity.legendary),
        rarity: AchievementRarity.legendary,
      ),
      Achievement(
        id: 'early_bird',
        titleKey: 'achEarlyBird',
        descriptionKey: 'achEarlyBirdDesc',
        category: AchievementCategory.streaks,
        icon: Icons.wb_sunny,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 5,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),

      // ==================== CALM ACHIEVEMENTS ====================
      Achievement(
        id: 'calm_10min',
        titleKey: 'achCalm10',
        descriptionKey: 'achCalm10Desc',
        category: AchievementCategory.calm,
        icon: Icons.self_improvement,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 10,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'calm_30min',
        titleKey: 'achCalm30',
        descriptionKey: 'achCalm30Desc',
        category: AchievementCategory.calm,
        icon: Icons.self_improvement,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 30,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
      Achievement(
        id: 'calm_1hour',
        titleKey: 'achCalm60',
        descriptionKey: 'achCalm60Desc',
        category: AchievementCategory.calm,
        icon: Icons.self_improvement,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 60,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'reduce_hyperactivity_20',
        titleKey: 'achReduceHyper20',
        descriptionKey: 'achReduceHyper20Desc',
        category: AchievementCategory.calm,
        icon: Icons.trending_down,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 20,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
      Achievement(
        id: 'reduce_hyperactivity_50',
        titleKey: 'achReduceHyper50',
        descriptionKey: 'achReduceHyper50Desc',
        category: AchievementCategory.calm,
        icon: Icons.trending_down,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.legendary,
        ),
        targetValue: 50,
        points: Achievement.getPointsForRarity(AchievementRarity.legendary),
        rarity: AchievementRarity.legendary,
      ),
      Achievement(
        id: 'perfect_posture',
        titleKey: 'achPerfectPosture',
        descriptionKey: 'achPerfectPostureDesc',
        category: AchievementCategory.calm,
        icon: Icons.accessibility_new,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 15,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),

      // ==================== MILESTONE ACHIEVEMENTS ====================
      Achievement(
        id: 'first_day',
        titleKey: 'achFirstDay',
        descriptionKey: 'achFirstDayDesc',
        category: AchievementCategory.milestones,
        icon: Icons.celebration,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.common,
        ),
        targetValue: 1,
        points: Achievement.getPointsForRarity(AchievementRarity.common),
        rarity: AchievementRarity.common,
      ),
      Achievement(
        id: 'first_week',
        titleKey: 'achFirstWeek',
        descriptionKey: 'achFirstWeekDesc',
        category: AchievementCategory.milestones,
        icon: Icons.calendar_today,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 7,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
      Achievement(
        id: 'first_month',
        titleKey: 'achFirstMonth',
        descriptionKey: 'achFirstMonthDesc',
        category: AchievementCategory.milestones,
        icon: Icons.calendar_month,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 30,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'tasks_100',
        titleKey: 'achTasks100',
        descriptionKey: 'achTasks100Desc',
        category: AchievementCategory.milestones,
        icon: Icons.check_circle,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 100,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
      Achievement(
        id: 'tasks_500',
        titleKey: 'achTasks500',
        descriptionKey: 'achTasks500Desc',
        category: AchievementCategory.milestones,
        icon: Icons.check_circle,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 500,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'tasks_1000',
        titleKey: 'achTasks1000',
        descriptionKey: 'achTasks1000Desc',
        category: AchievementCategory.milestones,
        icon: Icons.check_circle,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.legendary,
        ),
        targetValue: 1000,
        points: Achievement.getPointsForRarity(AchievementRarity.legendary),
        rarity: AchievementRarity.legendary,
      ),

      // ==================== SPECIAL ACHIEVEMENTS ====================
      Achievement(
        id: 'quick_learner',
        titleKey: 'achQuickLearner',
        descriptionKey: 'achQuickLearnerDesc',
        category: AchievementCategory.special,
        icon: Icons.flash_on,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 5,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
      Achievement(
        id: 'overachiever',
        titleKey: 'achOverachiever',
        descriptionKey: 'achOverachieverDesc',
        category: AchievementCategory.special,
        icon: Icons.workspace_premium,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.epic,
        ),
        targetValue: 7,
        points: Achievement.getPointsForRarity(AchievementRarity.epic),
        rarity: AchievementRarity.epic,
      ),
      Achievement(
        id: 'calm_master',
        titleKey: 'achCalmMaster',
        descriptionKey: 'achCalmMasterDesc',
        category: AchievementCategory.special,
        icon: Icons.spa,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.legendary,
        ),
        targetValue: 7,
        points: Achievement.getPointsForRarity(AchievementRarity.legendary),
        rarity: AchievementRarity.legendary,
      ),
      Achievement(
        id: 'explorer',
        titleKey: 'achExplorer',
        descriptionKey: 'achExplorerDesc',
        category: AchievementCategory.special,
        icon: Icons.explore,
        gradientColors: Achievement.getGradientForRarity(
          AchievementRarity.rare,
        ),
        targetValue: 4,
        points: Achievement.getPointsForRarity(AchievementRarity.rare),
        rarity: AchievementRarity.rare,
      ),
    ];
  }

  /// Get achievements by category
  static List<Achievement> getByCategory(AchievementCategory category) {
    return getAllAchievements()
        .where((achievement) => achievement.category == category)
        .toList();
  }

  /// Get achievement by ID
  static Achievement? getById(String id) {
    try {
      return getAllAchievements().firstWhere(
        (achievement) => achievement.id == id,
      );
    } catch (e) {
      return null;
    }
  }
}
