import 'dart:async';

import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  Timer? _timer;

  @override
  void onReady() {
    super.onReady();
    _timer = Timer(
      const Duration(milliseconds: 1600),
      () => Get.offAllNamed(AppRoutes.programOverview),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
