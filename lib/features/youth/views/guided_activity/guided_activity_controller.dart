import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';

class GuidedActivityController extends GetxController {
  final isPlaying = false.obs;
  final currentStep = 0.obs;

  void togglePlayback() => isPlaying.toggle();

  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  void nextStep() {
    if (currentStep.value < 3) currentStep.value++;
  }

  void finish() => Get.offNamed(AppRoutes.youthReflection);

  void onDailyTab(int index) => FlowNavigation.daily(3, index);

  void onNavigationTap(int index) => FlowNavigation.youth(0, index);
}
