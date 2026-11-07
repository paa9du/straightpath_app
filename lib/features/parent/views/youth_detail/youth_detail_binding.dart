import 'package:get/get.dart';

import 'youth_detail_controller.dart';

class YouthDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YouthDetailController>(YouthDetailController.new);
  }
}
