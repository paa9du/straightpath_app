import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/profile_content.dart';
import '../../../../shared/widgets/navigation/staff_page_scaffold.dart';
import 'coach_parent_profile_controller.dart';

class CoachParentProfileView extends GetView<CoachParentProfileController> {
  const CoachParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final flow = controller.flow;
    return ResponsiveLayout(
      child: StaffPageScaffold(
        currentIndex: 4,
        onNavigationTap: controller.onNavigationTap,
        body: ProfileContent(
          name: flow.profileName,
          imagePath: flow.profileImage,
          program: flow.profileProgram,
          onLogout: controller.showLogoutDialog,
          onDelete: controller.showDeleteDialog,
        ),
      ),
    );
  }
}
