import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mokrabela/components/cards/sticky_info_card.dart';
import 'package:sizer/sizer.dart';

void main() {
  // Helper to wrap widgets with Sizer
  Widget wrapWithSizer(Widget child) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(home: Scaffold(body: child));
      },
    );
  }

  group('StickyInfoCard Widget Tests', () {
    testWidgets('should display title and description when expanded', (
      WidgetTester tester,
    ) async {
      const title = 'Test Title';
      const description = 'Test Description';

      await tester.pumpWidget(
        wrapWithSizer(StickyInfoCard(title: title, description: description)),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(description), findsOneWidget);
    });

    testWidgets('should toggle expansion when tapped', (
      WidgetTester tester,
    ) async {
      const description = 'Test Description';

      await tester.pumpWidget(
        wrapWithSizer(
          StickyInfoCard(
            title: 'Title',
            description: description,
            initiallyExpanded: true,
          ),
        ),
      );

      // Verify initially expanded
      expect(find.text(description), findsOneWidget);

      // Tap to collapse
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Should be collapsed
      expect(find.text(description), findsNothing);

      // Tap to expand again
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Should be expanded again
      expect(find.text(description), findsOneWidget);
    });

    testWidgets('should display custom icon', (WidgetTester tester) async {
      const customIcon = Icons.music_note;

      await tester.pumpWidget(
        wrapWithSizer(
          StickyInfoCard(
            title: 'Title',
            description: 'Description',
            icon: customIcon,
          ),
        ),
      );

      expect(find.byIcon(customIcon), findsOneWidget);
    });

    testWidgets('should use default icon when not specified', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapWithSizer(
          StickyInfoCard(title: 'Title', description: 'Description'),
        ),
      );

      expect(find.byIcon(Icons.tips_and_updates), findsOneWidget);
    });

    testWidgets('should have AnimatedSize for smooth animation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapWithSizer(
          StickyInfoCard(title: 'Title', description: 'Description'),
        ),
      );

      expect(find.byType(AnimatedSize), findsOneWidget);
    });
  });
}
