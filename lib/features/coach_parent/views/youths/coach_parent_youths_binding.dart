import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_youths_controller.dart';

class CoachParentYouthsBinding extends Bindings {
  CoachParentYouthsBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentYouthsController>(() => CoachParentYouthsController(flow));
  }
}
