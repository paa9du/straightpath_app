import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import 'emotional_check_in_model.dart';
import 'widgets/support_dialog.dart';

class EmotionalCheckInController extends GetxController {
  final selectedFeeling = RxnString();
  final noteController = TextEditingController();
  final feelings = const <FeelingOption>[
    FeelingOption(assetPath: 'assets/emojis/1F60C.svg', label: 'Calm'),
    FeelingOption(assetPath: 'assets/emojis/1F642.svg', label: 'Ok'),
    FeelingOption(assetPath: 'assets/emojis/1F60A.svg', label: 'Happy'),
    FeelingOption(assetPath: 'assets/emojis/1F620.svg', label: 'Angry'),
    FeelingOption(assetPath: 'assets/emojis/1F630.svg', label: 'Anxious'),
    FeelingOption(assetPath: 'assets/emojis/1F629.svg', label: 'Overwhelmed'),
    FeelingOption(assetPath: 'assets/emojis/1F641.svg', label: 'Sad'),
    FeelingOption(assetPath: 'assets/emojis/1F611.svg', label: 'Neutral'),
    FeelingOption(assetPath: 'assets/emojis/1F62B.svg', label: 'Tired'),
  ];

  void selectFeeling(String value) => selectedFeeling.value = value;

  /// Figma 254:1852 – offers a grounding exercise before moving on.
  void continueFlow() {
    SupportDialog.show(
      onContinue: () {
        Get.back<void>();
        Get.offNamed(AppRoutes.youthFocus);
      },
      onSupport: () {
        Get.back<void>();
        Get.toNamed(AppRoutes.youthEmotionalRegulation);
      },
    );
  }

  void onDailyTab(int index) => FlowNavigation.daily(1, index);

  void onNavigationTap(int index) => FlowNavigation.youth(0, index);

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
