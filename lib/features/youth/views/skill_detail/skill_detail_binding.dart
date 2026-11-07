import 'package:get/get.dart';

import 'skill_detail_controller.dart';

class SkillDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SkillDetailController>(SkillDetailController.new);
  }
}
