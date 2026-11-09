import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/flow_navigation.dart';

/// Per-category look of the skill detail screen (title + sphere colours).
class SkillTheme {
  const SkillTheme(this.light, this.base, this.dark);
  final Color light;
  final Color base;
  final Color dark;
}

class SkillDetailController extends GetxController {
  static const themes = <String, SkillTheme>{
    'Calm': SkillTheme(Color(0xFF8FE3A8), Color(0xFF3FBF7F), Color(0xFF239A5E)),
    'Focus': SkillTheme(Color(0xFF8CCBE8), Color(0xFF3A8FB7), Color(0xFF256C93)),
    'Reset': SkillTheme(Color(0xFFC9A6F0), Color(0xFF8A5AC8), Color(0xFF6A3BA6)),
    'Ground': SkillTheme(Color(0xFFF08A80), Color(0xFFC0392B), Color(0xFF8E2A22)),
  };

  // Same exercise content is used by every category in the Figma designs.
  static const exerciseTitle = 'Box Breathing';
  static const steps = <String>[
    'Sit Comfortably And Rest Your Feet On The Floor.',
    'Breathe In Slowly Through Your Nose For 4 Seconds.',
    'Hold The Breath Gently For 4 Seconds.',
    'Breathe Out Slowly Through Your Mouth For 4 Seconds.',
    'Pause For 4 Seconds, Then Repeat 3–4 Times.',
  ];
  // Two exercise cards per screen.
  static const exerciseCount = 2;

  final title = (Get.arguments as String?) ?? 'Calm';
  SkillTheme get theme => themes[title] ?? themes['Calm']!;

  void onNavigationTap(int index) => FlowNavigation.youth(2, index);
}
