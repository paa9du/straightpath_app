import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import 'profile_details_controller.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});

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
                    'Profile Details',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 18,
                        color: const Color(0x22101720),
                      ),
                    ),
                    child: const Icon(Icons.person_outline, size: 112),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: controller.ageCategory.value,
                      hint: const Text('Age Category'),
                      items: const ['18 - 21', '22 - 25', '26 - 35', '36+']
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          controller.ageCategory.value = value,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: controller.program.value,
                      hint: const Text('Program'),
                      items:
                          const [
                                'Wellness Program',
                                'Behavioral Health',
                                'Youth Development',
                              ]
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                      onChanged: (value) => controller.program.value = value,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Continue',
                      onPressed: controller.continueToHome,
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
