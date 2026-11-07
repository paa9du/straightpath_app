import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import 'role_selection_model.dart';

class RoleSelectionController extends GetxController {
  final selectedRole = UserRole.youth.obs;

  void selectRole(UserRole role) => selectedRole.value = role;

  void continueToLogin() {
    Get.toNamed(AppRoutes.login, arguments: selectedRole.value.name);
  }
}
