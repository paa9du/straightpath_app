import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import '../../../../shared/widgets/text_fields/app_text_field.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: controller.goBack,
                            tooltip: 'Back',
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                        ),
                        Image.asset(AppAssets.logo, width: 150, height: 150),
                      ],
                    ),
                  ),
                  const SizedBox(height: 44),
                  Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please enter an email address that you used to create account with so we can send you an email to reset your password.',
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: AppColors.ink.withValues(alpha: .72)),
                  ),
                  const SizedBox(height: 36),
                  AppTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    prefixAsset: AppAssets.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 66),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Send',
                      onPressed: controller.sendResetEmail,
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
