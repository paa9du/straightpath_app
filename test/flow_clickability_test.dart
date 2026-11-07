import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:straight_path_app/app/routes/app_pages.dart';
import 'package:straight_path_app/app/routes/app_routes.dart';
import 'package:straight_path_app/core/theme/app_theme.dart';
import 'package:straight_path_app/shared/widgets/navigation/app_bottom_navigation.dart';

void main() {
  setUp(() => Get.testMode = true);
  tearDown(Get.reset);

  Future<void> pumpRoute(WidgetTester tester, String route) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        initialRoute: route,
        getPages: AppPages.pages,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'youth daily journey is clickable from start through reflection',
    (tester) async {
      await pumpRoute(tester, AppRoutes.youthHome);

      await tester.scrollUntilVisible(
        find.text('Start Today'),
        450,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Start Today'));
      await tester.pumpAndSettle();
      expect(find.text('How Would You Describe\nYour Mood?'), findsOneWidget);

      await tester.tap(find.text('Mood Check-In').last);
      await tester.pumpAndSettle();
      expect(find.text('How Are You Feeling Right Now?'), findsOneWidget);
      expect(
        tester
            .widget<AppBottomNavigation>(find.byType(AppBottomNavigation))
            .currentIndex,
        0,
      );

      await tester.scrollUntilVisible(
        find.text('Continue'),
        450,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Noticing Stress Without Judgment'), findsOneWidget);

      await tester.tap(find.text('Activity'));
      await tester.pumpAndSettle();
      expect(find.text('Take This At Your Own Pace.'), findsOneWidget);
      expect(
        tester
            .widget<AppBottomNavigation>(find.byType(AppBottomNavigation))
            .currentIndex,
        0,
      );

      await tester.scrollUntilVisible(
        find.text('Mark As Complete'),
        450,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Mark As Complete'));
      await tester.pumpAndSettle();
      expect(find.text('Take A Moment To Reflect'), findsOneWidget);

      await tester.tap(find.text('Voice Note'));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.mic_rounded));
      await tester.pump();
      expect(find.text('Recording... tap to stop'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Submit Reflection'),
        450,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Submit Reflection'));
      await tester.pumpAndSettle();
      expect(find.text('Michael Thompson'), findsOneWidget);
    },
  );

  testWidgets('coach cards open chat detail notes and add-note dialog', (
    tester,
  ) async {
    await pumpRoute(tester, AppRoutes.coachHome);

    await tester.tap(find.text('Send Message').first);
    await tester.pumpAndSettle();
    expect(find.text('Type something'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rick Martin').first);
    await tester.pumpAndSettle();
    expect(find.text('Course Progress'), findsOneWidget);

    await tester.tap(find.text('Explore ›'));
    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Add Note For Rick Martin'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'A new progress note.');
    await tester.tap(find.text('Add Note'));
    await tester.pump();
    expect(find.text('Saved'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
