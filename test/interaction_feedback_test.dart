import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:straight_path_app/app/routes/app_pages.dart';
import 'package:straight_path_app/app/routes/app_routes.dart';
import 'package:straight_path_app/core/theme/app_theme.dart';

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

  testWidgets('search surface opens an interactive search dialog', (
    tester,
  ) async {
    await pumpRoute(tester, AppRoutes.youthMessages);

    await tester.tap(find.text('Search Here'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('profile setting opens visible feedback', (tester) async {
    await pumpRoute(tester, AppRoutes.youthProfile);

    await tester.scrollUntilVisible(
      find.text('Notifications'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Notifications'), findsNWidgets(2));
  });

  testWidgets('guided activity controls change the selected step', (
    tester,
  ) async {
    await pumpRoute(tester, AppRoutes.youthGuidedActivity);

    await tester.ensureVisible(find.byTooltip('Next step'));
    await tester.tap(find.byTooltip('Next step'));
    await tester.pump();
    await tester.scrollUntilVisible(
      find.text('2. Take a slow breath in through your nose.'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(
      find.text('2. Take a slow breath in through your nose.'),
      findsOneWidget,
    );
  });

  testWidgets('weekly lesson tap provides visible feedback', (tester) async {
    await pumpRoute(tester, AppRoutes.youthWeeklyDetail);

    await tester.tap(find.text('Notice What You Feel'));
    await tester.pump();
    expect(find.text('Day 1: Notice What You Feel selected'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });
}
