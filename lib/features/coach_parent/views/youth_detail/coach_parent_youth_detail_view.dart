import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/youth_detail_content.dart';
import 'coach_parent_youth_detail_controller.dart';

class CoachParentYouthDetailView extends GetView<CoachParentYouthDetailController> {
  const CoachParentYouthDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        body: SafeArea(
          child: Obx(() => YouthDetailContent(
            person: controller.person,
            onBack: Get.back,
            onOpenNotes: controller.openNotes,
            onOpenChat: controller.openChat,
            trackerStates: controller.trackerStates.toList(),
            onToggleTracker: controller.toggleTracker,
          )),
        ),
      ),
    );
  }
}
