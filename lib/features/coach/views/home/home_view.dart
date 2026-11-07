import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/people_overview.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Obx(
        () => PeopleOverview(
          people: controller.people,
          currentIndex: controller.currentNavigationIndex.value,
          onNavigationTap: controller.selectNavigationItem,
          onPersonTap: controller.openPerson,
          onAddNote: controller.openNotes,
          onSendMessage: controller.openChat,
        ),
      ),
    );
  }
}
