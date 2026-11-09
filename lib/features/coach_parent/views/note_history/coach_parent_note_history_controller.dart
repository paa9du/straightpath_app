import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/models/person_summary.dart';
import '../../coach_parent_flow.dart';

class CoachParentNoteHistoryController extends GetxController {
  CoachParentNoteHistoryController(this.flow);

  final CoachParentFlow flow;
  late final PersonSummary person;
  final noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : flow.fallbackPerson;
  }

  void openChat() => Get.toNamed(flow.chatRoute, arguments: person);
  void clearNote() => noteController.clear();

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
