import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class MoodCheckInController extends GetxController {
  final selectedIndex = 3.obs;

  void select(int index) => selectedIndex.value = index;

  void back() => Get.back<void>();

  void continueFlow() => Get.offNamed(AppRoutes.youthEmotionalCheckIn);
}
