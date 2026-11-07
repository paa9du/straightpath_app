import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  void goBack() => Get.back<void>();

  void sendResetEmail() {
    Get.snackbar(
      'Email sent',
      'Check your inbox for password reset instructions.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
