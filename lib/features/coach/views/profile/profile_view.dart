import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/profile_content.dart';
import '../../../../shared/widgets/navigation/staff_page_scaffold.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: StaffPageScaffold(
        currentIndex: 4,
        onNavigationTap: controller.onNavigationTap,
        body: ProfileContent(
          name: 'Rick Martin',
          imagePath: AppAssets.rick,
          program: 'Wellness Program',
          onLogout: controller.showLogoutDialog,
          onDelete: controller.showDeleteDialog,
        ),
      ),
    );
  }
}
