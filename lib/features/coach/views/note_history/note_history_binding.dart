import 'package:get/get.dart';

import 'note_history_controller.dart';

class NoteHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteHistoryController>(NoteHistoryController.new);
  }
}
