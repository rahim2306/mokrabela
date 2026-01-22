import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/services/achievement_service.dart';
import 'package:mokrabela/components/dialogs/achievement_unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mokrabela/data/achievements_list.dart';

/// Service for saving exercise sessions to Firestore
class SessionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AchievementService _achievementService = AchievementService();

  /// Save a session to Firestore and track achievements
  Future<void> saveSession({
    required String childId,
    required String type,
    required String exerciseName,
    required String exerciseType,
    required DateTime startTime,
    required DateTime endTime,
    required bool completed,
    int? protocolSquare,
    double? stressLevelBefore,
    double? stressLevelAfter,
    double? avgMotionIntensity,
    double? peakHyperactivity,
    double? heartRateAvg,
    Map<String, dynamic>? exerciseData,
    BuildContext? context,
  }) async {
    final duration = endTime.difference(startTime).inSeconds;

    // Create session document
    final sessionRef = _firestore.collection('sessions').doc();
    await sessionRef.set({
      'sessionId': sessionRef.id,
      'childId': childId,
      'type': type,
      'exerciseName': exerciseName,
      'exerciseType': exerciseType,
      'protocolSquare': protocolSquare,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'duration': duration,
      'completed': completed,
      if (stressLevelBefore != null) 'stressLevelBefore': stressLevelBefore,
      if (stressLevelAfter != null) 'stressLevelAfter': stressLevelAfter,
      if (avgMotionIntensity != null) 'avgMotionIntensity': avgMotionIntensity,
      if (peakHyperactivity != null) 'peakHyperactivity': peakHyperactivity,
      if (heartRateAvg != null) 'heartRateAvg': heartRateAvg,
      if (exerciseData != null) 'exerciseData': exerciseData,
    });

    // Update daily protocol
    final dateStr = _formatDate(startTime);
    final dailyProtocolRef = _firestore
        .collection('dailyProtocols')
        .doc('${childId}_$dateStr');

    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(dailyProtocolRef);

      if (doc.exists) {
        final data = doc.data()!;
        transaction.update(dailyProtocolRef, {
          'totalFocusTime': (data['totalFocusTime'] ?? 0) + duration,
          'sessionsCompleted': (data['sessionsCompleted'] ?? 0) + 1,
        });
      } else {
        transaction.set(dailyProtocolRef, {
          'childId': childId,
          'date': dateStr,
          'totalFocusTime': duration,
          'sessionsCompleted': 1,
        });
      }
    });

    // Update protocol progress if applicable
    if (protocolSquare != null) {
      await updateProtocolProgress(childId, protocolSquare);
    }

    // Track achievements and get newly unlocked ones
    final unlockedAchievements = await _achievementService
        .trackSessionCompletion(childId, type, exerciseData ?? {});

    // Show unlock dialogs if any achievements were unlocked
    if (context != null && context.mounted && unlockedAchievements.isNotEmpty) {
      // Wait a brief moment to ensure screen is ready
      await Future.delayed(const Duration(milliseconds: 300));

      for (final achievementId in unlockedAchievements) {
        final achievement = AchievementsList.getById(achievementId);
        if (achievement != null && context.mounted) {
          try {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) =>
                  AchievementUnlockDialog(achievement: achievement),
            );
          } catch (e) {
            print('Error showing achievement unlock dialog: $e');
          }
        }
      }
    }
  }

  /// Update protocol progress in Firestore
  Future<void> updateProtocolProgress(String childId, int squareNumber) async {
    final progressRef = _firestore.collection('protocolProgress').doc(childId);

    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(progressRef);
      final timestamp = FieldValue.serverTimestamp();

      if (doc.exists) {
        final data = doc.data()!;
        final List<int> completed = List<int>.from(
          data['completedSquares'] ?? [],
        );
        if (!completed.contains(squareNumber)) {
          completed.add(squareNumber);
        }

        transaction.update(progressRef, {
          'completedSquares': completed,
          'square${squareNumber}Complete': true,
          'lastUpdated': timestamp,
          'currentSquare': squareNumber,
        });
      } else {
        transaction.set(progressRef, {
          'childId': childId,
          'currentSquare': squareNumber,
          'completedSquares': [squareNumber],
          'square${squareNumber}Complete': true,
          'lastUpdated': timestamp,
          'startedAt': timestamp,
        });
      }
    });
  }

  /// Format date as YYYY-MM-DD
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
