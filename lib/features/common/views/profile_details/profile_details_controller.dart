import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../role_selection/role_selection_model.dart';

class ProfileDetailsController extends GetxController {
  final nameController = TextEditingController();
  final ageCategory = RxnString();
  final program = RxnString();
  late final UserRole role;

  @override
  void onInit() {
    super.onInit();
    final roleName = Get.arguments as String?;
    role = UserRole.values.firstWhere(
      (value) => value.name == roleName,
      orElse: () => UserRole.coach,
    );
  }

  void continueToHome() {
    Get.offAllNamed(
      role == UserRole.parent ? AppRoutes.parentHome : AppRoutes.coachHome,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
