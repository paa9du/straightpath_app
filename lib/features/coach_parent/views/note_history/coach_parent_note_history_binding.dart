import 'package:get/get.dart';

import '../../coach_parent_flow.dart';
import 'coach_parent_note_history_controller.dart';

class CoachParentNoteHistoryBinding extends Bindings {
  CoachParentNoteHistoryBinding(this.flow);

  final CoachParentFlow flow;

  @override
  void dependencies() {
    Get.lazyPut<CoachParentNoteHistoryController>(() => CoachParentNoteHistoryController(flow));
  }
}
