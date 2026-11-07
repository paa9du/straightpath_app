import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/people_list.dart';
import '../../../../shared/widgets/navigation/staff_page_scaffold.dart';
import 'youths_controller.dart';

class YouthsView extends GetView<YouthsController> {
  const YouthsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: StaffPageScaffold(
        currentIndex: 1,
        onNavigationTap: controller.onNavigationTap,
        body: PeopleList(
          people: controller.people,
          onPersonTap: controller.openPerson,
        ),
      ),
    );
  }
}
