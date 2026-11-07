import 'package:get/get.dart';

import 'reflection_controller.dart';

class ReflectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReflectionController>(ReflectionController.new);
  }
}
