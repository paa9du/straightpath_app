import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../role_selection/role_selection_model.dart';

class OtpVerificationController extends GetxController {
  final otpController = TextEditingController();
  final otp = ''.obs;
  late final UserRole role;

  @override
  void onInit() {
    super.onInit();
    final roleName = Get.arguments as String?;
    role = UserRole.values.firstWhere(
      (value) => value.name == roleName,
      orElse: () => UserRole.youth,
    );
  }

  void updateOtp(String value) => otp.value = value;

  void verify() {
    if (role == UserRole.youth) {
      Get.offAllNamed(AppRoutes.youthIntake);
      return;
    }
    Get.offAllNamed(AppRoutes.profileDetails, arguments: role.name);
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
