import 'package:get/get.dart';

import 'mood_check_in_controller.dart';

class MoodCheckInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoodCheckInController>(MoodCheckInController.new);
  }
}
