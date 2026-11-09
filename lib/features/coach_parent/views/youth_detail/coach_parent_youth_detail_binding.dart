import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_youth_detail_controller.dart';

class CoachParentYouthDetailBinding extends Bindings {
  CoachParentYouthDetailBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentYouthDetailController>(() => CoachParentYouthDetailController(flow));
  }
}
