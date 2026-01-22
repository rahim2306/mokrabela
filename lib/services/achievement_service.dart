import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/models/achievement_model.dart';
import 'package:mokrabela/data/achievements_list.dart';

/// Service for managing achievements in Firestore
class AchievementService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Initialize achievements for a new user
  Future<void> initializeAchievements(String childId) async {
    final achievements = AchievementsList.getAllAchievements();
    final batch = _firestore.batch();

    for (final achievement in achievements) {
      final docRef = _firestore
          .collection('achievements')
          .doc('${childId}_${achievement.id}');

      // Check if already exists
      final doc = await docRef.get();
      if (!doc.exists) {
        batch.set(docRef, {
          'childId': childId,
          'achievementType': achievement.id,
          'currentValue': 0,
          'targetValue': achievement.targetValue,
          'isUnlocked': false,
          'progress': 0.0,
        });
      }
    }

    await batch.commit();
  }

  /// Get achievements stream for a child
  Stream<List<Achievement>> getAchievements(String childId) {
    return _firestore
        .collection('achievements')
        .where('childId', isEqualTo: childId)
        .snapshots()
        .map((snapshot) {
          final templates = AchievementsList.getAllAchievements();
          final achievements = <Achievement>[];

          for (final template in templates) {
            final docId = '${childId}_${template.id}';

            // Try to find the document
            try {
              final doc = snapshot.docs.firstWhere((d) => d.id == docId);
              final data = doc.data();
              achievements.add(Achievement.fromFirestore(data, template));
            } catch (e) {
              // Document doesn't exist yet, use template with zero progress
              achievements.add(template);
            }
          }

          return achievements;
        });
  }

  /// Update achievement progress
  Future<void> updateAchievementProgress(
    String childId,
    String achievementId,
    int newValue,
  ) async {
    final docRef = _firestore
        .collection('achievements')
        .doc('${childId}_$achievementId');

    final template = AchievementsList.getById(achievementId);
    if (template == null) return;

    final progress = (newValue / template.targetValue).clamp(0.0, 1.0);
    final isUnlocked = newValue >= template.targetValue;

    await docRef.update({
      'currentValue': newValue,
      'progress': progress,
      'isUnlocked': isUnlocked,
      if (isUnlocked && newValue == template.targetValue)
        'unlockedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Track session completion and update relevant achievements
  Future<List<String>> trackSessionCompletion(
    String childId,
    String sessionType,
    Map<String, dynamic> sessionData,
  ) async {
    final unlockedAchievements = <String>[];

    // Get current counts from Firestore
    final sessionsSnapshot = await _firestore
        .collection('sessions')
        .where('childId', isEqualTo: childId)
        .get();

    // Count sessions by type
    final breathingCount = sessionsSnapshot.docs
        .where((d) => d['type'] == 'breathing')
        .length;
    final focusCount = sessionsSnapshot.docs
        .where((d) => d['type'] == 'focus')
        .length;
    final musicCount = sessionsSnapshot.docs
        .where((d) => d['type'] == 'music')
        .length;
    final storyCount = sessionsSnapshot.docs
        .where((d) => d['type'] == 'story')
        .length;
    final totalCount = sessionsSnapshot.docs.length;

    // Calculate total calm time (in minutes)
    final totalDuration = sessionsSnapshot.docs.fold<int>(
      0,
      (total, doc) => total + ((doc.data()['duration'] as int?) ?? 0),
    );
    final totalMinutes = (totalDuration / 60).floor();

    // Update breathing achievements
    if (sessionType == 'breathing') {
      await _updateIfNeeded(
        childId,
        'breathing_first',
        breathingCount,
        unlockedAchievements,
      );
      await _updateIfNeeded(
        childId,
        'breathing_5',
        breathingCount,
        unlockedAchievements,
      );
      await _updateIfNeeded(
        childId,
        'breathing_10',
        breathingCount,
        unlockedAchievements,
      );
      await _updateIfNeeded(
        childId,
        'breathing_master',
        breathingCount,
        unlockedAchievements,
      );
    }

    // Update focus achievements
    if (sessionType == 'focus') {
      await _updateIfNeeded(
        childId,
        'focus_first',
        focusCount,
        unlockedAchievements,
      );
      await _updateIfNeeded(
        childId,
        'focus_champion',
        focusCount,
        unlockedAchievements,
      );
    }

    // Update music achievements
    if (sessionType == 'music') {
      await _updateIfNeeded(
        childId,
        'music_beginner',
        musicCount,
        unlockedAchievements,
      );
      await _updateIfNeeded(
        childId,
        'music_expert',
        musicCount,
        unlockedAchievements,
      );
    }

    // Update story achievements
    if (sessionType == 'story') {
      await _updateIfNeeded(
        childId,
        'story_starter',
        storyCount,
        unlockedAchievements,
      );
      await _updateIfNeeded(
        childId,
        'story_master',
        storyCount,
        unlockedAchievements,
      );
    }

    // Update calm time achievements
    await _updateIfNeeded(
      childId,
      'calm_10min',
      totalMinutes,
      unlockedAchievements,
    );
    await _updateIfNeeded(
      childId,
      'calm_30min',
      totalMinutes,
      unlockedAchievements,
    );
    await _updateIfNeeded(
      childId,
      'calm_1hour',
      totalMinutes,
      unlockedAchievements,
    );

    // Update milestone achievements
    await _updateIfNeeded(
      childId,
      'first_day',
      totalCount > 0 ? 1 : 0,
      unlockedAchievements,
    );
    await _updateIfNeeded(
      childId,
      'tasks_100',
      totalCount,
      unlockedAchievements,
    );
    await _updateIfNeeded(
      childId,
      'tasks_500',
      totalCount,
      unlockedAchievements,
    );
    await _updateIfNeeded(
      childId,
      'tasks_1000',
      totalCount,
      unlockedAchievements,
    );

    // Calculate streaks from dailyProtocols
    await _updateStreakAchievements(childId, unlockedAchievements);

    return unlockedAchievements;
  }

  /// Helper to update achievement if needed
  Future<void> _updateIfNeeded(
    String childId,
    String achievementId,
    int newValue,
    List<String> unlockedList,
  ) async {
    final docRef = _firestore
        .collection('achievements')
        .doc('${childId}_$achievementId');

    final doc = await docRef.get();
    if (!doc.exists) return;

    final data = doc.data()!;
    final currentValue = data['currentValue'] as int;
    final wasUnlocked = data['isUnlocked'] as bool;

    if (newValue > currentValue) {
      await updateAchievementProgress(childId, achievementId, newValue);

      // Check if newly unlocked
      final template = AchievementsList.getById(achievementId);
      if (template != null &&
          !wasUnlocked &&
          newValue >= template.targetValue) {
        unlockedList.add(achievementId);
      }
    }
  }

  /// Update streak-based achievements
  Future<void> _updateStreakAchievements(
    String childId,
    List<String> unlockedList,
  ) async {
    // Get daily protocols sorted by date
    final protocolsSnapshot = await _firestore
        .collection('dailyProtocols')
        .where('childId', isEqualTo: childId)
        .orderBy('date', descending: true)
        .get();

    if (protocolsSnapshot.docs.isEmpty) return;

    // Calculate current streak
    int currentStreak = 0;
    DateTime? lastDate;

    for (final doc in protocolsSnapshot.docs) {
      final dateStr = doc['date'] as String;
      final date = DateTime.parse(dateStr);

      if (lastDate == null) {
        currentStreak = 1;
        lastDate = date;
      } else {
        final difference = lastDate.difference(date).inDays;
        if (difference == 1) {
          currentStreak++;
          lastDate = date;
        } else {
          break;
        }
      }
    }

    // Update streak achievements
    await _updateIfNeeded(childId, 'streak_3', currentStreak, unlockedList);
    await _updateIfNeeded(childId, 'streak_7', currentStreak, unlockedList);
    await _updateIfNeeded(childId, 'streak_14', currentStreak, unlockedList);
    await _updateIfNeeded(childId, 'streak_30', currentStreak, unlockedList);
  }

  /// Get total points for a child
  Future<int> getTotalPoints(String childId) async {
    final snapshot = await _firestore
        .collection('achievements')
        .where('childId', isEqualTo: childId)
        .where('isUnlocked', isEqualTo: true)
        .get();

    int totalPoints = 0;
    for (final doc in snapshot.docs) {
      final achievementId = doc['achievementType'] as String;
      final template = AchievementsList.getById(achievementId);
      if (template != null) {
        totalPoints += template.points;
      }
    }

    return totalPoints;
  }
}
