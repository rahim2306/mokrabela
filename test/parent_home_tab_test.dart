import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/protocol_enrollment_model.dart';
import 'package:mokrabela/screens/parent/parent_home_tab.dart';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockProtocolService extends Mock implements ProtocolService {}

void main() {
  late MockProtocolService mockProtocolService;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    mockProtocolService = MockProtocolService();
    fakeFirestore = FakeFirebaseFirestore();
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
            body: ParentHomeTab(
              selectedChildId: 'test-child-id',
              protocolService: mockProtocolService,
              firestore: fakeFirestore,
            ),
          ),
        );
      },
    );
  }

  group('ParentHomeTab Tests', () {
    testWidgets('Shows default empty state if no enrollment or sessions', (
      tester,
    ) async {
      // Mock protocol service to return no enrollment initially
      when(
        () => mockProtocolService.getEnrollmentStream(any()),
      ).thenAnswer((_) => Stream.value(null));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Should show overview title
      expect(find.text('Overview'), findsOneWidget);
      // Stats should be zero
      expect(find.text('0'), findsNWidgets(2)); // Sessions and Streak
    });

    testWidgets('Shows enrollment data and derived stats', (tester) async {
      // Add fake sessions to firestore
      await fakeFirestore.collection('sessions').add({
        'childId': 'test-child-id',
        'startTime': Timestamp.now(),
        'duration': 600, // 10 minutes
        'type': 'breathing',
      });

      final enrollment = ProtocolEnrollment(
        childId: 'test-child-id',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 35)),
        currentWeek: 2,
        status: ProtocolStatus.active,
      );

      when(
        () => mockProtocolService.getEnrollmentStream(any()),
      ).thenAnswer((_) => Stream.value(enrollment));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify streak (from currentWeek)
      expect(find.text('2'), findsOneWidget);
      // Verify sessions count (1)
      expect(find.text('1'), findsOneWidget);
      // Verify time (10 min)
      expect(find.text('10'), findsOneWidget);
    });
  });
}
