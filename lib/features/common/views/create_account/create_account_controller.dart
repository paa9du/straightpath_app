import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class CreateAccountController extends GetxController {
  final uniqueIdController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscurePassword = true.obs;
  late final String roleName;

  @override
  void onInit() {
    super.onInit();
    roleName = Get.arguments as String? ?? 'youth';
  }

  void togglePasswordVisibility() => obscurePassword.toggle();

  void createAccount() =>
      Get.toNamed(AppRoutes.otpVerification, arguments: roleName);

  void backToLogin() => Get.back<void>();

  @override
  void onClose() {
    uniqueIdController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
