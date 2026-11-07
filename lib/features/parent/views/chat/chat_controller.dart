import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';

class ChatController extends GetxController {
  late final PersonSummary person;
  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : MockPeople.parent.first;
  }

  void send() => messageController.clear();

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
