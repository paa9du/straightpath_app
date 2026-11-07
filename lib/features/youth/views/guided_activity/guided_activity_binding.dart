import 'package:get/get.dart';

import 'guided_activity_controller.dart';

class GuidedActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuidedActivityController>(GuidedActivityController.new);
  }
}
