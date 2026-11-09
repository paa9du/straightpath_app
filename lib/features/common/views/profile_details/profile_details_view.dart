import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import 'profile_details_controller.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});

  static const _ages = ['18 - 21', '22 - 25', '26 - 35', '36+'];
  static const _programs = [
    'Wellness Program',
    'Behavioral Health',
    'Youth Development',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: AppBackground(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 13, 20, 14),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 27,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const Text(
                            'Profile Details',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 33 / 24,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 19),
                          SizedBox(
                            width: 250,
                            height: 250,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 116,
                                  height: 116,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/profile_halftone.png',
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          _Field(
                            child: TextField(
                              controller: controller.nameController,
                              style: _textStyle(AppColors.ink),
                              cursorColor: AppColors.ink,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: _textStyle(
                                  AppColors.ink.withValues(alpha: .5),
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: false,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => _Dropdown(
                              hint: 'Age Category',
                              value: controller.ageCategory.value,
                              items: _ages,
                              onChanged: (v) => controller.ageCategory.value = v,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => _Dropdown(
                              hint: 'Program',
                              value: controller.program.value,
                              items: _programs,
                              onChanged: (v) => controller.program.value = v,
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(height: 24),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle _textStyle(Color color) => TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400,
  color: color,
);

class _Field extends StatelessWidget {
  const _Field({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 28, right: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          borderRadius: BorderRadius.circular(12),
          dropdownColor: Colors.white,
          icon: SvgPicture.asset(AppAssets.chevronDown24, width: 24, height: 24),
          hint: Text(hint, style: _textStyle(AppColors.ink.withValues(alpha: .5))),
          style: _textStyle(AppColors.ink),
          items: [
            for (final item in items)
              DropdownMenuItem(value: item, child: Text(item)),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
