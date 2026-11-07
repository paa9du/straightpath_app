import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/flow_navigation.dart';

class ProfileController extends GetxController {
  void onNavigationTap(int index) => FlowNavigation.youth(4, index);

  void showLogoutDialog() {
    Get.dialog<void>(
      AlertDialog(
        title: const Center(child: Text('Logout')),
        content: const Text(
          'Are You Sure You Want To Logout?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: 150,
            child: OutlinedButton(
              onPressed: Get.back<void>,
              child: const Text('Cancel'),
            ),
          ),
          SizedBox(
            width: 150,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink.withValues(alpha: .8),
              ),
              onPressed: () => Get.offAllNamed(AppRoutes.roleSelection),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog() {
    Get.dialog<void>(
      AlertDialog(
        title: const Center(child: Text('Delete Account')),
        content: const Text(
          'Are You Sure You Want To Delete Your Account?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          OutlinedButton(
            onPressed: Get.back<void>,
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.coral),
            onPressed: () => Get.offAllNamed(AppRoutes.roleSelection),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
