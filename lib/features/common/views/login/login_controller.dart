import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../role_selection/role_selection_model.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;
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

  void togglePasswordVisibility() => obscurePassword.toggle();

  void openForgotPassword() => Get.toNamed(AppRoutes.forgotPassword);

  void openCreateAccount() =>
      Get.toNamed(AppRoutes.createAccount, arguments: role.name);

  void login() {
    final route = switch (role) {
      UserRole.youth => AppRoutes.youthHome,
      UserRole.coach => AppRoutes.coachHome,
      UserRole.parent => AppRoutes.parentHome,
    };
    Get.offAllNamed(route);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
