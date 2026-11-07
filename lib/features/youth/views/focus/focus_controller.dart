import 'package:get/get.dart';

import '../../../../core/utils/flow_navigation.dart';

class FocusController extends GetxController {
  void onDailyTab(int index) => FlowNavigation.daily(2, index);

  void onNavigationTap(int index) => FlowNavigation.youth(0, index);
}
