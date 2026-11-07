import 'package:get/get.dart';

import 'emotional_check_in_controller.dart';

class EmotionalCheckInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmotionalCheckInController>(EmotionalCheckInController.new);
  }
}
