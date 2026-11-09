import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import 'otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({super.key});

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
                    child: Image.asset(AppAssets.logo, width: 150, height: 150),
                  ),
                  const SizedBox(height: 44),
                  Text(
                    'OTP has been sent to your email. Enter the code below to continue.',
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: AppColors.ink.withValues(alpha: .72)),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                            // 54px boxes when they fit, otherwise shrink so
                            // six boxes never overflow narrow screens.
                            final box = ((constraints.maxWidth - 5 * 6) / 6)
                                .clamp(36.0, 54.0)
                                .toDouble();
                          // Obx must be inside the builder so the observable is
                          // read within its own reactive scope.
                          return Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            final value = index < controller.otp.value.length
                                ? controller.otp.value[index]
                                : '';
                            return Container(
                              width: box,
                              height: box,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.divider),
                              ),
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          }),
                            ),
                          );
                        },
                      ),
                      Positioned.fill(
                        child: Opacity(
                          opacity: .01,
                          child: TextField(
                            controller: controller.otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            autofocus: true,
                            onChanged: controller.updateOtp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Verify',
                      onPressed: controller.verify,
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
