import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';

class NoteHistoryController extends GetxController {
  late final PersonSummary person;
  final noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : MockPeople.all.first;
  }

  void openChat() => Get.toNamed(AppRoutes.coachChat, arguments: person);
  void clearNote() => noteController.clear();

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
