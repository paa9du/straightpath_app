import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/notes_list.dart';
import '../../../../shared/widgets/navigation/staff_page_scaffold.dart';
import 'notes_controller.dart';

class NotesView extends GetView<NotesController> {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: StaffPageScaffold(
        currentIndex: 2,
        onNavigationTap: controller.onNavigationTap,
        body: NotesList(
          people: controller.people,
          onPersonTap: controller.openNotes,
        ),
      ),
    );
  }
}
