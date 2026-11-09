import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import 'role_selection_controller.dart';
import 'role_selection_model.dart';
import 'widgets/role_card.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: AppBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
              child: Column(
                children: [
                  Text(
                    'Role Selection',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: Obx(() {
                      final selectedRole = controller.selectedRole.value;
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: UserRole.values.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final role = UserRole.values[index];
                          return RoleCard(
                            role: role,
                            selected: selectedRole == role,
                            onTap: () => controller.selectRole(role),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Next',
                      onPressed: controller.continueToLogin,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
