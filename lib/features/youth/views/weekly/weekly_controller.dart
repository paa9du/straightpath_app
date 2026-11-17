import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import '../../../../data/mock/mock_weeks.dart';
import 'weekly_model.dart';

class WeeklyController extends GetxController {
  final _store = WeeklyProgressStore.to;

  /// Read inside an `Obx` so the cards update after a day is completed.
  List<WeekProgress> get weeks => [
    for (final w in MockWeeks.all)
      WeekProgress(
        week: w.number,
        title: w.title,
        description: w.description,
        dateRange: w.dateRange,
        progress: _store.progress(w.number),
        completedDays: _store.completedDays(w.number),
      ),
  ];

  void onNavigationTap(int index) => FlowNavigation.youth(1, index);

  void openWeek(int week) {
    Get.toNamed(AppRoutes.youthWeeklyDetail, arguments: week);
  }
}
