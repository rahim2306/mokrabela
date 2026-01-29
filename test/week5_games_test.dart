import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Using mocktail as per project pattern
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For User mock
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/screens/child/focus/math_puzzle_game.dart';
import 'package:mokrabela/screens/child/focus/memory_sequence_game.dart';

// Mocks
class MockAuthService extends Mock implements AuthService {}

class MockSessionService extends Mock implements SessionService {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthService mockAuthService;
  late MockSessionService mockSessionService;
  late MockUser mockUser;

  setUp(() {
    mockAuthService = MockAuthService();
    mockSessionService = MockSessionService();
    mockUser = MockUser();

    // Default mocks
    when(() => mockUser.uid).thenReturn('test-uid');
    when(() => mockAuthService.currentUser).thenReturn(mockUser);

    // Register fallback values if needed (SessionService args are likely primitives or Maps)
    registerFallbackValue(DateTime.now());
  });

  Widget createWidgetUnderTest(Widget child) {
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
          home: child,
        );
      },
    );
  }

  group('Math Puzzle Game Tests', () {
    testWidgets('Renders Start Screen correctly', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          MathPuzzleGame(
            authService: mockAuthService,
            sessionService: mockSessionService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Math Puzzle'), findsOneWidget);
      expect(find.text('START GAME'), findsOneWidget);
      expect(find.byIcon(Icons.calculate_rounded), findsOneWidget);
    });

    testWidgets('Tapping Start Game changes state', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          MathPuzzleGame(
            authService: mockAuthService,
            sessionService: mockSessionService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Start
      await tester.tap(find.text('START GAME'));
      await tester.pump(); // Start animation/timer
      await tester.pump(const Duration(seconds: 1)); // Wait for 1 tick

      // Should show Score
      expect(find.text('Score: 0'), findsOneWidget);
      // Should find a math question (contains '= ?')
      expect(find.textContaining('= ?'), findsOneWidget);
    });
  });

  group('Memory Sequence Game Tests', () {
    testWidgets('Renders Start Screen correctly', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          MemorySequenceGame(
            authService: mockAuthService,
            sessionService: mockSessionService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Memory Training'), findsOneWidget);
      expect(find.text('START'), findsOneWidget);
    });

    testWidgets('Tapping Start starts game loop', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          MemorySequenceGame(
            authService: mockAuthService,
            sessionService: mockSessionService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Start
      await tester.tap(find.text('START'));
      await tester.pump();
      await tester.pump(
        const Duration(seconds: 2),
      ); // Allow async sequence to play

      // Should show "Watch Closely..." or "Your Turn!"
      // Since it's a random sequence, it might be showing or done showing
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('Round: 1'), findsOneWidget);
    });
  });
}
