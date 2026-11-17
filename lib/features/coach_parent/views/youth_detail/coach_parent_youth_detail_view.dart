import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/youth_detail_content.dart';
import 'coach_parent_youth_detail_controller.dart';

class CoachParentYouthDetailView extends GetView<CoachParentYouthDetailController> {
  const CoachParentYouthDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(() => YouthDetailContent(
                  person: controller.person,
                  onBack: Get.back,
                  onOpenNotes: controller.openNotes,
                  onOpenChat: controller.openChat,
                  trackerStates: controller.trackerStates.toList(),
                  onToggleTracker: controller.toggleTracker,
                )),
              ),
              if (controller.showConnectWithCoach)
                // Figma 766-1816: 320×60, centred below the card and inset
                // ~20px from the card edges on each side.
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 12, 40, 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: AppPrimaryButton(
                        label: 'Connect With Coach',
                        height: 60,
                        onPressed: controller.connectWithCoach,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
