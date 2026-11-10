import 'dart:async';

import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';

class GuidedActivityController extends GetxController {
  static const _totalSeconds = 150; // 2:30

  final isPlaying = true.obs;
  final currentStep = 0.obs;
  final remainingSeconds = _totalSeconds.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void togglePlayback() {
    isPlaying.toggle();
    if (isPlaying.value) {
      _startTimer();
    } else {
      _timer?.cancel();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  void nextStep() {
    if (currentStep.value < 3) currentStep.value++;
  }

  void finish() => Get.offNamed(AppRoutes.youthReflection);

  void onDailyTab(int index) => FlowNavigation.daily(3, index);

  void onNavigationTap(int index) => FlowNavigation.youth(0, index);

  String get timeLabel {
    final s = remainingSeconds.value;
    final m = s ~/ 60;
    final sec = s % 60;
    return '$m:${sec.toString().padLeft(2, '0')}';
  }

  double get timerProgress => remainingSeconds.value / _totalSeconds;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _timer?.cancel();
        isPlaying.value = false;
      }
    });
  }
}
