import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_home_controller.dart';

class CoachParentHomeBinding extends Bindings {
  CoachParentHomeBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentHomeController>(() => CoachParentHomeController(flow));
  }
}
