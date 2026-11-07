import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import 'emotional_check_in_model.dart';

class EmotionalCheckInController extends GetxController {
  final selectedFeeling = RxnString();
  final noteController = TextEditingController();
  final feelings = const <FeelingOption>[
    FeelingOption(emoji: '😌', label: 'Calm'),
    FeelingOption(emoji: '🙂', label: 'Ok'),
    FeelingOption(emoji: '😊', label: 'Happy'),
    FeelingOption(emoji: '😠', label: 'Angry'),
    FeelingOption(emoji: '😥', label: 'Anxious'),
    FeelingOption(emoji: '😩', label: 'Overwhelmed'),
    FeelingOption(emoji: '☹️', label: 'Sad'),
    FeelingOption(emoji: '😐', label: 'Neutral'),
    FeelingOption(emoji: '🥱', label: 'Tired'),
  ];

  void selectFeeling(String value) => selectedFeeling.value = value;

  void continueFlow() => Get.offNamed(AppRoutes.youthFocus);

  void onDailyTab(int index) => FlowNavigation.daily(1, index);

  void onNavigationTap(int index) => FlowNavigation.youth(0, index);

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
