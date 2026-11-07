import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';

class ReflectionController extends GetxController {
  final mode = 0.obs;
  final noteController = TextEditingController();
  final isRecording = false.obs;

  void setMode(int value) => mode.value = value;
  void toggleRecording() => isRecording.toggle();
  void submit() => Get.offAllNamed(AppRoutes.youthHome);
  void onDailyTab(int index) => FlowNavigation.daily(4, index);
  void onNavigationTap(int index) => FlowNavigation.youth(0, index);

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
