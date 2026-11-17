import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../data/mock/mock_weeks.dart';

/// past = completed (mint), today = first unfinished weekday (yellow),
/// upcoming = later weekdays (white), weekend = Sat/Sun rest days (grey).
enum WeekDayStatus { past, today, upcoming, weekend }

/// Week overview (Figma 754:1247, screen 147).
/// Tapping a past day or today only selects it. Continue then opens the
/// Completed screen (148) for a past day, or Questions (149) for today.
class WeeklyDetailController extends GetxController {
  final _store = WeeklyProgressStore.to;

  late final WeekContent week;
  final selectedDay = 0.obs;

  @override
  void onInit() {
    super.onInit();
    week = MockWeeks.byNumber((Get.arguments as int?) ?? 1);
    // Start on today, or on Monday when the whole week is done.
    selectedDay.value = weekDone ? 0 : completedDays;
  }

  int get completedDays => _store.completedDays(week.number);
  double get progress => _store.progress(week.number);
  bool get weekDone => _store.isWeekDone(week.number);

  WeekDayStatus statusOf(int day) {
    if (isWeekendDay(day)) return WeekDayStatus.weekend;
    final done = completedDays;
    if (day < done) return WeekDayStatus.past;
    if (day == done) return WeekDayStatus.today;
    return WeekDayStatus.upcoming;
  }

  bool isSelectable(int day) {
    final s = statusOf(day);
    return s == WeekDayStatus.past || s == WeekDayStatus.today;
  }

  void selectDay(int day) {
    if (isSelectable(day)) selectedDay.value = day;
  }

  void continueTap() {
    final day = selectedDay.value;
    final args = WeeklyDayArgs(week: week.number, dayIndex: day);
    switch (statusOf(day)) {
      case WeekDayStatus.past:
        Get.toNamed(AppRoutes.youthWeeklyDayCompleted, arguments: args);
      case WeekDayStatus.today:
        Get.toNamed(AppRoutes.youthWeeklyDayQuestions, arguments: args);
      case WeekDayStatus.upcoming:
      case WeekDayStatus.weekend:
        break;
    }
  }
}
