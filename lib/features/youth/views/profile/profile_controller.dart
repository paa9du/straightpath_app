import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../shared/widgets/common/app_confirm_dialog.dart';
import '../../../../core/utils/flow_navigation.dart';

class ProfileController extends GetxController {
  final notificationsOn = false.obs;

  void onNavigationTap(int index) => FlowNavigation.youth(4, index);

  void showLogoutDialog() {
    Get.dialog<void>(
      AppConfirmDialog(
        title: 'Logout',
        message: 'Are You Sure You Want To Logout?',
        confirmLabel: 'Logout',
        onConfirm: () => Get.offAllNamed(AppRoutes.roleSelection),
      ),
    );
  }

  void showDeleteDialog() {
    Get.dialog<void>(
      AppConfirmDialog(
        title: 'Delete Account',
        message:
            'Are You Sure You Want To Delete Your Account?\nThis Action Is Permanent And Irreversible.',
        confirmLabel: 'Delete',
        onConfirm: () => Get.offAllNamed(AppRoutes.roleSelection),
      ),
    );
  }
}
