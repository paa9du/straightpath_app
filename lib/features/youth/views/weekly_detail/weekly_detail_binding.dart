import 'package:get/get.dart';

import 'weekly_detail_controller.dart';

class WeeklyDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeeklyDetailController>(WeeklyDetailController.new);
  }
}
