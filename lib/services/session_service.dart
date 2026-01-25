import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/services/achievement_service.dart';
import 'package:mokrabela/components/dialogs/achievement_unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mokrabela/data/achievements_list.dart';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:mokrabela/services/ble_service.dart';

/// Service for saving exercise sessions to Firestore
class SessionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AchievementService _achievementService = AchievementService();
  final ProtocolService _protocolService = ProtocolService();
  final BleService _bleService = BleService();

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

    // Fetch biometrics from watch if not provided
    final currentStats = _bleService.statistics;
    final liveData = _bleService.sensorData;

    final finalStressAfter =
        stressLevelAfter ??
        (liveData['activityLevel']
            ?.toDouble()); // Using activity level as a proxy if direct stress not avail
    final finalMotion =
        avgMotionIntensity ??
        (currentStats['avgMovementIntensity']?.toDouble() ?? 0.0);
    final finalHyper =
        peakHyperactivity ??
        (currentStats['peakHyperactivityIndex']?.toDouble() ?? 0.0);

    // Fetch protocol week
    int? protocolWeek;
    try {
      final enrollment = await _protocolService.ensureEnrollment(childId);
      protocolWeek = enrollment.calculateCurrentWeek(DateTime.now());
    } catch (e) {
      print('Error fetching enrollment for session: $e');
    }

    // Create session document
    final sessionRef = _firestore.collection('sessions').doc();
    await sessionRef.set({
      'sessionId': sessionRef.id,
      'childId': childId,
      'type': type,
      'exerciseName': exerciseName,
      'exerciseType': exerciseType,
      if (protocolSquare != null) 'protocolSquare': protocolSquare,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'duration': duration,
      'completed': completed,
      // Biometric fields at root level per schema
      if (stressLevelBefore != null) 'stressLevelBefore': stressLevelBefore,
      if (finalStressAfter != null) 'stressLevelAfter': finalStressAfter,
      if (finalMotion != null) 'avgMotionIntensity': finalMotion,
      if (finalHyper != null) 'peakHyperactivity': finalHyper,
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

  /// Get all sessions belonging to the protocol (squares 1-4)
  /// Note: Filters by protocolSquare client-side to avoid composite index
  Stream<QuerySnapshot<Map<String, dynamic>>> getProtocolSessionsStream(
    String childId,
  ) {
    return _firestore
        .collection('sessions')
        .where('childId', isEqualTo: childId)
        .orderBy('startTime', descending: true)
        .snapshots();
  }

  /// Format date as YYYY-MM-DD
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
