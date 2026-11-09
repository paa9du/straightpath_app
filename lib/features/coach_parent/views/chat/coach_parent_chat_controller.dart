import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/models/person_summary.dart';
import '../../coach_parent_flow.dart';

class CoachParentChatController extends GetxController {
  CoachParentChatController(this.flow);

  final CoachParentFlow flow;
  late final PersonSummary person;
  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : flow.fallbackPerson;
  }

  void send() => messageController.clear();

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
