import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import 'widgets/intake_complete_dialog.dart';

class IntakeController extends GetxController {
  final step = 0.obs;
  final selected = <String>{}.obs;
  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final ageController = TextEditingController();
  final languageController = TextEditingController();
  final guardianNameController = TextEditingController();
  final guardianEmailController = TextEditingController();

  void toggle(String value) {
    if (!selected.add(value)) selected.remove(value);
  }

  void back() {
    if (step.value > 0) {
      step.value--;
    } else {
      Get.back<void>();
    }
  }

  void next() {
    if (step.value < 3) {
      step.value++;
    } else {
      IntakeCompleteDialog.show(
        onGetStarted: () => Get.offAllNamed(AppRoutes.youthHome),
      );
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    ageController.dispose();
    languageController.dispose();
    guardianNameController.dispose();
    guardianEmailController.dispose();
    super.onClose();
  }
}
