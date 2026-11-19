import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../data/mock/mock_weeks.dart';
import 'worksheet_completed_dialog.dart';

/// Day worksheet (Figma 760:2093, 878:3423, 878:3508, 878:3580). One screen
/// per part with all of that part's questions; Next moves to the next part.
/// After Part D the day is marked complete and the "Worksheet Completed!"
/// popup (Figma 873:2941) is shown.
class WeeklyDayQuestionsController extends GetxController {
  final _store = WeeklyProgressStore.to;

  late final WeeklyDayArgs args;
  late final WeekContent week;
  final DayContent day = MockWeeks.day;

  final partIndex = 0.obs;

  /// Question indices (in the current part) whose cards are collapsed.
  final collapsed = <int>{}.obs;

  final scroll = ScrollController();

  /// [part][question][answer box].
  late final List<List<List<TextEditingController>>> answers;

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
          for (final q in part.questions)
            [for (var i = 0; i < q.answerCount; i++) TextEditingController()],
        ],
    ];
  }

  @override
  void onClose() {
    for (final part in answers) {
      for (final question in part) {
        for (final c in question) {
          c.dispose();
        }
      }
    }
    scroll.dispose();
    super.onClose();
  }

  String get dayName => weekDayNames[args.dayIndex];
  String get dateLabel => dayLabel(week, args.dayIndex);

  /// "Monday Worksheet" (Figma 760:2108).
  String get title => '$dayName Worksheet';
  DayPart get part => day.parts[partIndex.value];
  List<List<TextEditingController>> get partFields => answers[partIndex.value];
  bool get isLastPart => partIndex.value == day.parts.length - 1;

  bool isExpanded(int question) => !collapsed.contains(question);

  void toggleQuestion(int question) {
    if (!collapsed.remove(question)) collapsed.add(question);
  }

  void _goToPart(int index) {
    partIndex.value = index;
    collapsed.clear();
    if (scroll.hasClients) scroll.jumpTo(0);
  }

  void back() {
    if (partIndex.value > 0) {
      _goToPart(partIndex.value - 1);
    } else {
      Get.back();
    }
  }

  void submit() {
    final answered = partFields.every(
      (question) => question.any((c) => c.text.trim().isNotEmpty),
    );
    if (!answered) {
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Please answer each question before continuing.'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 1600),
            ),
          );
      }
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    if (!isLastPart) {
      _goToPart(partIndex.value + 1);
      return;
    }
    _store.completeDay(args.week, args.dayIndex);
    WorksheetCompletedDialog.show(
      dayName: dayName,
      onContinue: () {
        Get.back<void>();
        Get.offNamed(AppRoutes.youthWeeklyDayCompleted, arguments: args);
      },
    );
  }
}
