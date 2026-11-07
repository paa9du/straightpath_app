import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:straight_path_app/app/app.dart';

void main() {
  setUp(() => Get.testMode = true);
  tearDown(Get.reset);

  testWidgets(
    'onboarding reaches role login and forgot password can return',
    (tester) async {
      tester.view.physicalSize = const Size(402, 874);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const StraightPathApp());

      expect(find.byType(StraightPathApp), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 1700));
      await tester.pumpAndSettle();

      expect(find.text('Program Overview'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);

      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      expect(find.text('Role Selection'), findsOneWidget);
      expect(find.text('YOUTH'), findsOneWidget);
      expect(find.text('COACH'), findsOneWidget);
      expect(find.text('PARENT'), findsOneWidget);
      expect(find.byType(Scrollable), findsNothing);

      await tester.tap(find.text('COACH'));
      await tester.pump();
      await tester.ensureVisible(find.text('Next'));
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Don’t Have An Account? Create'), findsOneWidget);

      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Back'), findsOneWidget);
      expect(find.text('Send'), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(find.text('Don’t Have An Account? Create'), findsOneWidget);
    },
  );
}
