import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/app_background.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: AppBackground(
          child: Center(
            child: Image.asset(
              AppAssets.logo,
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
