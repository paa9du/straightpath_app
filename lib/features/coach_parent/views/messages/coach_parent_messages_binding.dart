import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_messages_controller.dart';

class CoachParentMessagesBinding extends Bindings {
  CoachParentMessagesBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentMessagesController>(() => CoachParentMessagesController(flow));
  }
}
