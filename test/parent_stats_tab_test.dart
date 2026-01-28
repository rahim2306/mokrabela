import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/stats_models.dart';
import 'package:mokrabela/screens/parent/parent_stats_tab.dart';
import 'package:mokrabela/services/stats_service.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockStatsService extends Mock implements StatsService {}

void main() {
  late MockStatsService mockStatsService;

  setUp(() {
    registerFallbackValue(DateTime.now());
    mockStatsService = MockStatsService();
  });

  Widget createWidgetUnderTest() {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          locale: const Locale('en'),
          home: Scaffold(
            body: ParentStatsTab(
              selectedChildId: 'test-child-id',
              statsService: mockStatsService,
            ),
          ),
        );
      },
    );
  }

  group('ParentStatsTab Tests', () {
    testWidgets('Shows loading indicator initially', (tester) async {
      // Setup default mock responses to return futures that haven't completed yet
      // or just don't pump immediately
      when(() => mockStatsService.getStats(any(), any(), any())).thenAnswer(
        (_) async => StatsData(
          totalSessions: 10,
          totalMinutes: 100,
          avgStressReduction: 2.5,
          currentStreak: 0,
        ),
      );
      when(
        () => mockStatsService.getDailySessionCounts(any(), any(), any()),
      ).thenAnswer((_) async => []);
      when(
        () => mockStatsService.getStressHistory(any(), any(), any()),
      ).thenAnswer((_) async => []);
      when(
        () => mockStatsService.getProtocolCompletion(any()),
      ).thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());

      // Should find CircularProgressIndicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(); // Allow futures to complete
    });

    testWidgets('Shows stats when data is loaded', (tester) async {
      final statsData = StatsData(
        totalSessions: 5,
        totalMinutes: 45,
        avgStressReduction: 1.5,
        currentStreak: 0,
      );

      when(
        () => mockStatsService.getStats(any(), any(), any()),
      ).thenAnswer((_) async => statsData);
      when(
        () => mockStatsService.getDailySessionCounts(any(), any(), any()),
      ).thenAnswer((_) async => []);
      when(
        () => mockStatsService.getStressHistory(any(), any(), any()),
      ).thenAnswer((_) async => []);
      when(
        () => mockStatsService.getProtocolCompletion(any()),
      ).thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify stats are displayed
      expect(find.text('5'), findsOneWidget); // Sessions
      expect(find.text('45m'), findsOneWidget); // Minutes
      expect(find.text('1.5'), findsOneWidget); // Stress reduction
      expect(find.text('Activity Trends'), findsOneWidget);
    });

    testWidgets('Shows error message when data loading fails', (tester) async {
      when(
        () => mockStatsService.getStats(any(), any(), any()),
      ).thenThrow(Exception('Network error'));
      when(
        () => mockStatsService.getDailySessionCounts(any(), any(), any()),
      ).thenAnswer((_) async => []);
      when(
        () => mockStatsService.getStressHistory(any(), any(), any()),
      ).thenAnswer((_) async => []);
      when(
        () => mockStatsService.getProtocolCompletion(any()),
      ).thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Error loading stats'), findsOneWidget);
      expect(find.text('Exception: Network error'), findsOneWidget);
    });
  });
}
