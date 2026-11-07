import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/messages_list.dart';
import '../../../../shared/widgets/navigation/staff_page_scaffold.dart';
import 'messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: StaffPageScaffold(
        currentIndex: 3,
        onNavigationTap: controller.onNavigationTap,
        body: MessagesList(
          people: controller.people,
          onPersonTap: controller.openChat,
        ),
      ),
    );
  }
}
