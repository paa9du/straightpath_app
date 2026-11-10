import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/chat_content.dart';
import 'coach_parent_chat_controller.dart';

class CoachParentChatView extends GetView<CoachParentChatController> {
  const CoachParentChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        body: SafeArea(
          child: ChatContent(
            name: controller.person.name,
            imagePath: controller.person.imagePath,
            messages: controller.messages,
            messageController: controller.messageController,
            onBack: Get.back,
            onSend: controller.send,
          ),
        ),
      ),
    );
  }
}
