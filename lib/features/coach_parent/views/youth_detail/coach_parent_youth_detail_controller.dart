import 'package:get/get.dart';

import '../../../../shared/models/person_summary.dart';
import '../../coach_parent_flow.dart';

class CoachParentYouthDetailController extends GetxController {
  CoachParentYouthDetailController(this.flow);

  final CoachParentFlow flow;
  late final PersonSummary person;

  final trackerStates = [false, false, false, false].obs;

  void toggleTracker(int index) {
    trackerStates[index] = !trackerStates[index];
  }

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : flow.fallbackPerson;
  }

  void openNotes() => Get.toNamed(flow.noteHistoryRoute, arguments: person);
  void openChat() => Get.toNamed(flow.chatRoute, arguments: person);
}
