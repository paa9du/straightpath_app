import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import '../../../../shared/widgets/text_fields/app_text_field.dart';
import 'create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: AppBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(AppAssets.logo, width: 145, height: 145),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    controller: controller.uniqueIdController,
                    hintText: 'Unique Username / ID',
                    prefixAsset: AppAssets.editProfile,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: controller.usernameController,
                    hintText: 'Username',
                    prefixAsset: AppAssets.profile,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    prefixAsset: AppAssets.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => AppTextField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      prefixAsset: AppAssets.lock,
                      suffixAsset: AppAssets.show,
                      obscureText: controller.obscurePassword.value,
                      onSuffixTap: controller.togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => AppTextField(
                      controller: controller.confirmPasswordController,
                      hintText: 'Confirm Password',
                      prefixAsset: AppAssets.lock,
                      suffixAsset: AppAssets.show,
                      obscureText: controller.obscurePassword.value,
                      onSuffixTap: controller.togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Create Account',
                      onPressed: controller.createAccount,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: controller.backToLogin,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Already Have An Account? '),
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: AppColors.coral,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
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
