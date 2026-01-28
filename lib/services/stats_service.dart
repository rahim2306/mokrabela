import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/models/stats_models.dart';
import 'package:logger/logger.dart';

/// Service for aggregating session statistics from Firestore
class StatsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _logger = Logger();

  Future<StatsData> getStats(
    String childId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final sessions = await _getSessions(childId, startDate, endDate);

      int totalSessions = sessions.length;
      int totalSeconds = 0;
      double totalStressReduction = 0;
      int sessionsWithStress = 0;

      for (final session in sessions) {
        final data = session.data() as Map<String, dynamic>?;
        if (data == null) continue;

        // Sum duration
        totalSeconds += (data['duration'] as num?)?.toInt() ?? 0;

        // Calculate stress reduction if data exists
        // Note: Schema only has stressLevelAfter, no stressLevelBefore
        final beforeStress = (data['stressLevelBefore'] as num?)?.toInt();
        final afterStress = (data['stressLevelAfter'] as num?)?.toInt();
        if (beforeStress != null && afterStress != null) {
          totalStressReduction += (beforeStress - afterStress);
          sessionsWithStress++;
        }
      }

      final avgStressReduction = sessionsWithStress > 0
          ? totalStressReduction / sessionsWithStress
          : 0.0;

      // Calculate streak (simplified: consecutive days with sessions)
      final streak = await _calculateStreak(childId, endDate);

      return StatsData(
        totalSessions: totalSessions,
        totalMinutes: (totalSeconds / 60).round(),
        avgStressReduction: avgStressReduction,
        currentStreak: streak,
      );
    } catch (e, stackTrace) {
      _logger.e(
        'StatsService.getStats ERROR',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Get daily session counts for bar chart
  Future<List<DailySessionCount>> getDailySessionCounts(
    String childId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final sessions = await _getSessions(childId, startDate, endDate);

    // Group by date
    final Map<String, List<QueryDocumentSnapshot>> byDate = {};
    for (final session in sessions) {
      final data = session.data() as Map<String, dynamic>;
      final timestamp = (data['startTime'] as Timestamp).toDate();
      final dateKey = _formatDate(timestamp);

      byDate.putIfAbsent(dateKey, () => []);
      byDate[dateKey]!.add(session);
    }

    // Create daily counts
    final List<DailySessionCount> dailyCounts = [];
    DateTime current = startDate;
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      final dateKey = _formatDate(current);
      final sessionDocs = byDate[dateKey] ?? [];

      int totalSeconds = 0;
      for (final doc in sessionDocs) {
        final data = doc.data() as Map<String, dynamic>;
        totalSeconds += (data['duration'] as num?)?.toInt() ?? 0;
      }

      dailyCounts.add(
        DailySessionCount(
          date: current,
          count: sessionDocs.length,
          totalMinutes: (totalSeconds / 60).round(),
        ),
      );

      current = current.add(const Duration(days: 1));
    }

    return dailyCounts;
  }

  /// Get stress history for line chart
  Future<List<StressDataPoint>> getStressHistory(
    String childId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final sessions = await _getSessions(childId, startDate, endDate);

    final List<StressDataPoint> dataPoints = [];

    for (final session in sessions) {
      final data = session.data() as Map<String, dynamic>;
      final beforeStress = (data['stressLevelBefore'] as num?)?.toInt();
      final afterStress = (data['stressLevelAfter'] as num?)?.toInt();

      if (beforeStress != null && afterStress != null) {
        final timestamp = (data['startTime'] as Timestamp).toDate();
        dataPoints.add(
          StressDataPoint(
            timestamp: timestamp,
            beforeStress: beforeStress,
            afterStress: afterStress,
          ),
        );
      }
    }

    return dataPoints;
  }

  /// Get protocol week completion data
  Future<List<WeekProgress>> getProtocolCompletion(String childId) async {
    final List<WeekProgress> weeksList = [];

    for (int week = 1; week <= 5; week++) {
      try {
        final doc = await _firestore
            .collection('protocolWeeks')
            .doc('${childId}_$week')
            .get();

        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          weeksList.add(
            WeekProgress(
              weekIndex: week,
              sessionsCompleted: data['totalSessionsCompleted'] ?? 0,
              totalMinutes: data['totalFocusTime'] ?? 0,
            ),
          );
        } else {
          // Week not started yet
          weeksList.add(
            WeekProgress(
              weekIndex: week,
              sessionsCompleted: 0,
              totalMinutes: 0,
            ),
          );
        }
      } catch (e) {
        // Week doc doesn't exist
        weeksList.add(
          WeekProgress(weekIndex: week, sessionsCompleted: 0, totalMinutes: 0),
        );
      }
    }

    return weeksList;
  }

  Future<List<QueryDocumentSnapshot>> getRawSessions(
    String childId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _getSessions(childId, startDate, endDate);
  }

  // ===== PRIVATE HELPERS =====

  Future<List<QueryDocumentSnapshot>> _getSessions(
    String childId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Query sessions for this child WITHOUT orderBy to avoid composite index
      final query = await _firestore
          .collection('sessions')
          .where('childId', isEqualTo: childId)
          .get();

      // Filter by date range client-side (INCLUSIVE on both ends)
      final filtered = query.docs.where((doc) {
        final data = doc.data();
        // Use startTime field (NOT timestamp)
        final timestamp = (data['startTime'] as Timestamp?)?.toDate();
        if (timestamp == null) return false;

        // Use inclusive comparison: startDate <= timestamp <= endDate
        final isInRange =
            !timestamp.isBefore(startDate) && !timestamp.isAfter(endDate);
        return isInRange;
      }).toList();

      // Sort by startTime descending (newest first) client-side
      filtered.sort((a, b) {
        final aTime = (a.data()['startTime'] as Timestamp?)?.toDate();
        final bTime = (b.data()['startTime'] as Timestamp?)?.toDate();
        if (aTime == null || bTime == null) return 0;
        return bTime.compareTo(aTime); // Descending
      });

      return filtered;
    } catch (e) {
      _logger.e('StatsService._getSessions ERROR', error: e);
      rethrow;
    }
  }

  Future<int> _calculateStreak(String childId, DateTime endDate) async {
    int streak = 0;
    DateTime current = DateTime(endDate.year, endDate.month, endDate.day);

    // Check backwards day by day
    for (int i = 0; i < 30; i++) {
      // Max 30 days checked
      final dayStart = current.subtract(Duration(days: i));
      final dayEnd = dayStart.add(const Duration(days: 1));

      final sessions = await _getSessions(childId, dayStart, dayEnd);

      if (sessions.isNotEmpty) {
        streak++;
      } else if (i > 0) {
        // Break streak if no sessions (but not on first day)
        break;
      }
    }

    return streak;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
