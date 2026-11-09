import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/note_history_content.dart';
import '../../../../shared/widgets/dialogs/add_note_dialog.dart';
import 'coach_parent_note_history_controller.dart';

class CoachParentNoteHistoryView extends GetView<CoachParentNoteHistoryController> {
  const CoachParentNoteHistoryView({super.key});

  void _addNote() {
    AddNoteDialog.show(
      controller: controller.noteController,
      onSubmit: () {
        controller.clearNote();
        Get.back<void>();
        Get.snackbar('Saved', 'Note added successfully');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        body: SafeArea(
          child: NoteHistoryContent(
            person: controller.person,
            onBack: Get.back,
            onAddNote: _addNote,
            onEditNote: _addNote,
            onOpenChat: controller.openChat,
          ),
        ),
      ),
    );
  }
}
