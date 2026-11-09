import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../shared/widgets/common/app_confirm_dialog.dart';
import '../../coach_parent_flow.dart';

class CoachParentProfileController extends GetxController {
  CoachParentProfileController(this.flow);

  final CoachParentFlow flow;

  void onNavigationTap(int index) => flow.navigate(4, index);

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
