import 'dart:math' as math;

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const titleHeight = 33.0;
                  const titleGap = 18.0;
                  const cardGap = 10.0;
                  const buttonGap = 12.0;
                  const buttonHeight = 60.0;
                  const fixedHeight =
                      titleHeight +
                      titleGap +
                      (cardGap * 2) +
                      buttonGap +
                      buttonHeight;
                  final cardHeight = math.min(
                    220.0,
                    math.max(120.0, (constraints.maxHeight - fixedHeight) / 3),
                  );

                  return Column(
                    children: [
                      SizedBox(
                        height: titleHeight,
                        child: Text(
                          'Role Selection',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(height: titleGap),
                      Obx(() {
                        final selectedRole = controller.selectedRole.value;
                        return Column(
                          children: List.generate(UserRole.values.length, (
                            index,
                          ) {
                            final role = UserRole.values[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == UserRole.values.length - 1
                                    ? 0
                                    : cardGap,
                              ),
                              child: SizedBox(
                                height: cardHeight,
                                child: RoleCard(
                                  role: role,
                                  selected: selectedRole == role,
                                  onTap: () => controller.selectRole(role),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                      const Spacer(),
                      const SizedBox(height: buttonGap),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: AppPrimaryButton(
                          label: 'Next',
                          onPressed: controller.continueToLogin,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
