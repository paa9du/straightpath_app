import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

abstract final class FlowNavigation {
  static const youthRoutes = [
    AppRoutes.youthHome,
    AppRoutes.youthWeekly,
    AppRoutes.youthSkills,
    AppRoutes.youthMessages,
    AppRoutes.youthProfile,
  ];

  static const coachRoutes = [
    AppRoutes.coachHome,
    AppRoutes.coachYouths,
    AppRoutes.coachNotes,
    AppRoutes.coachMessages,
    AppRoutes.coachProfile,
  ];

  static const parentRoutes = [
    AppRoutes.parentHome,
    AppRoutes.parentYouths,
    AppRoutes.parentNotes,
    AppRoutes.parentMessages,
    AppRoutes.parentProfile,
  ];

  static const dailyRoutes = [
    AppRoutes.youthHome,
    AppRoutes.youthEmotionalCheckIn,
    AppRoutes.youthFocus,
    AppRoutes.youthGuidedActivity,
    AppRoutes.youthReflection,
  ];

  static void youth(int currentIndex, int targetIndex) {
    if (currentIndex == targetIndex ||
        targetIndex < 0 ||
        targetIndex >= youthRoutes.length) {
      return;
    }
    Get.offNamed(youthRoutes[targetIndex]);
  }

  static void coach(int currentIndex, int targetIndex) {
    _go(coachRoutes, currentIndex, targetIndex);
  }

  static void parent(int currentIndex, int targetIndex) {
    _go(parentRoutes, currentIndex, targetIndex);
  }

  static void daily(int currentIndex, int targetIndex) {
    _go(dailyRoutes, currentIndex, targetIndex);
  }

  static void _go(List<String> routes, int currentIndex, int targetIndex) {
    if (currentIndex == targetIndex ||
        targetIndex < 0 ||
        targetIndex >= routes.length) {
      return;
    }
    Get.offNamed(routes[targetIndex]);
  }
}
