import 'package:get/get.dart';

import '../../../../core/utils/flow_navigation.dart';

class WeeklyDetailController extends GetxController {
  final week = (Get.arguments as int?) ?? 1;
  void onNavigationTap(int index) => FlowNavigation.youth(1, index);
}
