import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import 'weekly_model.dart';

class WeeklyController extends GetxController {
  final weeks = const <WeekProgress>[
    WeekProgress(
      week: 1,
      title: 'Emotional Regulation',
      description:
          'Develop awareness of emotions as they arise, without judgment.',
      dateRange: '23 Jan 2026 - 29 Jan 2026',
      progress: 1,
      completedDays: 7,
    ),
    WeekProgress(
      week: 2,
      title: 'Communication & Conflict Resolution',
      description:
          'Develop awareness of emotions as they arise, without judgment.',
      dateRange: '30 Jan 2026 - 5 Feb 2026',
      progress: .75,
      completedDays: 4,
    ),
    WeekProgress(
      week: 3,
      title: 'Accountability & Decision-Making',
      description:
          'Develop awareness of emotions as they arise, without judgment.',
      dateRange: '6 Feb 2026 - 12 Feb 2026',
      progress: 0,
      completedDays: 0,
    ),
    WeekProgress(
      week: 4,
      title: 'Building Healthy Habits',
      description: 'Practice small routines that support steady growth.',
      dateRange: '13 Feb 2026 - 19 Feb 2026',
      progress: 0,
      completedDays: 0,
    ),
  ];

  void onNavigationTap(int index) => FlowNavigation.youth(1, index);

  void openWeek(int week) {
    Get.toNamed(AppRoutes.youthWeeklyDetail, arguments: week);
  }
}
