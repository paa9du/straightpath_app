import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/common/note_history_content.dart';
import 'note_history_controller.dart';

class NoteHistoryView extends GetView<NoteHistoryController> {
  const NoteHistoryView({super.key});

  void _addNote() {
    Get.dialog<void>(
      AlertDialog(
        title: Text('Add Note For ${controller.person.name}'),
        content: TextField(
          controller: controller.noteController,
          minLines: 5,
          maxLines: 7,
          decoration: const InputDecoration(hintText: 'Write note here...'),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              controller.clearNote();
              Get.back<void>();
              Get.snackbar('Saved', 'Note added successfully');
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.coral),
            child: const Text('Add Note'),
          ),
        ],
      ),
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
