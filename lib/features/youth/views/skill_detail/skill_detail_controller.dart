import 'package:get/get.dart';

import '../../../../core/utils/flow_navigation.dart';

class SkillDetailController extends GetxController {
  final title = (Get.arguments as String?) ?? 'Calm';
  final selected = 0.obs;
  void choose(int value) => selected.value = value;
  void onNavigationTap(int index) => FlowNavigation.youth(2, index);
}
