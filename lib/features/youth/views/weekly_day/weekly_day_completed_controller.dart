import 'package:get/get.dart';

import '../../../../data/mock/mock_weeks.dart';

/// Completed day (Figma 148).
class WeeklyDayCompletedController extends GetxController {
  late final WeeklyDayArgs args;
  late final WeekContent week;
  final DayContent day = MockWeeks.day;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments is WeeklyDayArgs
        ? Get.arguments as WeeklyDayArgs
        : const WeeklyDayArgs(week: 1, dayIndex: 0);
    week = MockWeeks.byNumber(args.week);
  }

  String get dateLabel => dayLabel(week, args.dayIndex);
  String get dayName => weekDayNames[args.dayIndex];
  String get insight => day.insight.replaceAll('{day}', dayName);
}
