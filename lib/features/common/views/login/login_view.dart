import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import '../../../../shared/widgets/text_fields/app_text_field.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: AppBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppAssets.logo,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 44),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 28),
                  AppTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixAsset: AppAssets.email,
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
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.openForgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Login',
                      onPressed: controller.login,
                    ),
                  ),
                  const SizedBox(height: 58),
                  Center(
                    child: TextButton(
                      onPressed: controller.openCreateAccount,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Don’t Have An Account? '),
                            TextSpan(
                              text: 'Create',
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
