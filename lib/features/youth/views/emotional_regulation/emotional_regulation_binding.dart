import 'package:get/get.dart';

import 'emotional_regulation_controller.dart';

class EmotionalRegulationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmotionalRegulationController>(
      EmotionalRegulationController.new,
    );
  }
}
