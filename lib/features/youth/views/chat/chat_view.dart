import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/chat_content.dart';
import 'chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

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
