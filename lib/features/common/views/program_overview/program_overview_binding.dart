import 'package:get/get.dart';

import 'program_overview_controller.dart';

class ProgramOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgramOverviewController>(ProgramOverviewController.new);
  }
}
