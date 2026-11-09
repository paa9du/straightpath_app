import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_profile_controller.dart';

class CoachParentProfileBinding extends Bindings {
  CoachParentProfileBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentProfileController>(() => CoachParentProfileController(flow));
  }
}
