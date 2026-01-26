/// Statistics data aggregated for a time period
class StatsData {
  final int totalSessions;
  final int totalMinutes;
  final double avgStressReduction;
  final int currentStreak;

  StatsData({
    required this.totalSessions,
    required this.totalMinutes,
    required this.avgStressReduction,
    required this.currentStreak,
  });
}

/// Daily session count for charts
class DailySessionCount {
  final DateTime date;
  final int count;
  final int totalMinutes;

  DailySessionCount({
    required this.date,
    required this.count,
    required this.totalMinutes,
  });
}

/// Stress level data point for trend charts
class StressDataPoint {
  final DateTime timestamp;
  final int beforeStress;
  final int afterStress;

  StressDataPoint({
    required this.timestamp,
    required this.beforeStress,
    required this.afterStress,
  });

  int get reduction => beforeStress - afterStress;
}

/// Weekly protocol progress
class WeekProgress {
  final int weekIndex;
  final int sessionsCompleted;
  final int totalMinutes;

  WeekProgress({
    required this.weekIndex,
    required this.sessionsCompleted,
    required this.totalMinutes,
  });

  double get progressPercent => (sessionsCompleted / 14 * 100).clamp(0, 100);
}
