import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:straight_path_app/app/routes/app_pages.dart';
import 'package:straight_path_app/app/routes/app_routes.dart';
import 'package:straight_path_app/core/theme/app_theme.dart';

void main() {
  final routes = <String>[
    AppRoutes.programOverview,
    AppRoutes.roleSelection,
    AppRoutes.login,
    AppRoutes.forgotPassword,
    AppRoutes.createAccount,
    AppRoutes.otpVerification,
    AppRoutes.profileDetails,
    AppRoutes.youthIntake,
    AppRoutes.youthHome,
    AppRoutes.youthWeekly,
    AppRoutes.youthWeeklyDetail,
    AppRoutes.youthMoodCheckIn,
    AppRoutes.youthEmotionalCheckIn,
    AppRoutes.youthFocus,
    AppRoutes.youthGuidedActivity,
    AppRoutes.youthReflection,
    AppRoutes.youthSkills,
    AppRoutes.youthSkillDetail,
    AppRoutes.youthMessages,
    AppRoutes.youthChat,
    AppRoutes.youthProfile,
    AppRoutes.coachHome,
    AppRoutes.coachYouths,
    AppRoutes.coachYouthDetail,
    AppRoutes.coachNotes,
    AppRoutes.coachNoteHistory,
    AppRoutes.coachMessages,
    AppRoutes.coachChat,
    AppRoutes.coachProfile,
    AppRoutes.parentHome,
    AppRoutes.parentYouths,
    AppRoutes.parentYouthDetail,
    AppRoutes.parentNotes,
    AppRoutes.parentNoteHistory,
    AppRoutes.parentMessages,
    AppRoutes.parentChat,
    AppRoutes.parentProfile,
  ];

  setUp(() => Get.testMode = true);
  tearDown(Get.reset);

  test('every declared screen has a registered GetX page', () {
    final registered = AppPages.pages.map((page) => page.name).toSet();
    expect(registered, containsAll(<String>[AppRoutes.splash, ...routes]));
    expect(registered.length, 38);
  });

  for (final route in routes) {
    testWidgets('$route renders without an exception', (tester) async {
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
      await tester.pump(const Duration(milliseconds: 300));

      expect(tester.takeException(), isNull);
    });
  }
}
