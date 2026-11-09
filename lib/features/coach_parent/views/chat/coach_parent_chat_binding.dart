import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_chat_controller.dart';

class CoachParentChatBinding extends Bindings {
  CoachParentChatBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentChatController>(() => CoachParentChatController(flow));
  }
}
