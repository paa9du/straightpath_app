import 'package:get/get.dart';

import 'youths_controller.dart';

class YouthsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YouthsController>(YouthsController.new);
  }
}
