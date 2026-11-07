import 'package:get/get.dart';

import 'weekly_controller.dart';

class WeeklyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeeklyController>(WeeklyController.new);
  }
}
