import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_notes_controller.dart';

class CoachParentNotesBinding extends Bindings {
  CoachParentNotesBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentNotesController>(() => CoachParentNotesController(flow));
  }
}
