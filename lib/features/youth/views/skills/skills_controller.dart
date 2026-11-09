import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import 'skills_model.dart';
import 'widgets/feeling_sheet.dart';

class SkillsController extends GetxController {
  final categories = const <SkillCategory>[
    SkillCategory(name: 'Calm', cropIndex: 0),
    SkillCategory(name: 'Focus', cropIndex: 1),
    SkillCategory(name: 'Reset', cropIndex: 2),
    SkillCategory(name: 'Ground', cropIndex: 3),
  ];

  void onNavigationTap(int index) => FlowNavigation.youth(2, index);

  void openFeeling(int index) => FeelingSheet.show(feelingInfos[index]);

  void openSkill(String name) {
    Get.toNamed(AppRoutes.youthSkillDetail, arguments: name);
  }
}
