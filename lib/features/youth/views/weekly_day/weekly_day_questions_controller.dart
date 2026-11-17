import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../data/mock/mock_weeks.dart';

/// Day questions (Figma 760:2093, screen 149). Shows one question card at a
/// time, as in Figma: Submit & Continue moves to the part's next question,
/// then to the next part. After the last question the day is marked
/// complete and the Completed screen replaces this one.
class WeeklyDayQuestionsController extends GetxController {
  final _store = WeeklyProgressStore.to;

  late final WeeklyDayArgs args;
  late final WeekContent week;
  final DayContent day = MockWeeks.day;

  final partIndex = 0.obs;
  final questionIndex = 0.obs;
  final expanded = true.obs;
  final canSubmit = false.obs;

  late final List<List<TextEditingController>> answers;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments is WeeklyDayArgs
        ? Get.arguments as WeeklyDayArgs
        : const WeeklyDayArgs(week: 1, dayIndex: 0);
    week = MockWeeks.byNumber(args.week);
    answers = [
      for (final part in day.parts)
        [
          for (final _ in part.questions)
            TextEditingController()..addListener(_refreshCanSubmit),
        ],
    ];
  }

  @override
  void onClose() {
    for (final part in answers) {
      for (final c in part) {
        c.dispose();
      }
    }
    super.onClose();
  }

  String get dateLabel => dayLabel(week, args.dayIndex);
  DayPart get part => day.parts[partIndex.value];
  DayQuestion get question => part.questions[questionIndex.value];
  TextEditingController get answer =>
      answers[partIndex.value][questionIndex.value];

  bool get _isLastQuestionOfPart =>
      questionIndex.value == part.questions.length - 1;
  bool get _isLastPart => partIndex.value == day.parts.length - 1;

  void _refreshCanSubmit() {
    canSubmit.value = answer.text.trim().isNotEmpty;
  }

  void _goTo(int partI, int questionI) {
    partIndex.value = partI;
    questionIndex.value = questionI;
    expanded.value = true;
    _refreshCanSubmit();
  }

  void toggleQuestion() => expanded.toggle();

  void back() {
    if (questionIndex.value > 0) {
      _goTo(partIndex.value, questionIndex.value - 1);
    } else if (partIndex.value > 0) {
      final prev = partIndex.value - 1;
      _goTo(prev, day.parts[prev].questions.length - 1);
    } else {
      Get.back();
    }
  }

  void submit() {
    if (!canSubmit.value) {
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Please write your answer before continuing.'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 1600),
            ),
          );
      }
      return;
    }
    if (!_isLastQuestionOfPart) {
      _goTo(partIndex.value, questionIndex.value + 1);
    } else if (!_isLastPart) {
      _goTo(partIndex.value + 1, 0);
    } else {
      _store.completeDay(args.week, args.dayIndex);
      Get.offNamed(AppRoutes.youthWeeklyDayCompleted, arguments: args);
    }
  }
}
