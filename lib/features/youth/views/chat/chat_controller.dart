import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../shared/models/person_summary.dart';

class ChatController extends GetxController {
  late final PersonSummary person;
  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : const PersonSummary(
            name: 'Rick Martin',
            program: '',
            imagePath: AppAssets.rick,
            completedSteps: 0,
          );
  }

  void send() => messageController.clear();

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
