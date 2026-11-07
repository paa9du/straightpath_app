import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/flow_navigation.dart';
import 'home_model.dart';

class HomeController extends GetxController {
  final currentNavigationIndex = 0.obs;
  final selectedMoodIndex = 3.obs;

  final moods = const <MoodOption>[
    MoodOption(label: 'Very Bad', assetPath: AppAssets.moodVeryBad),
    MoodOption(label: 'Sad', assetPath: AppAssets.moodSad),
    MoodOption(label: 'Neutral', assetPath: AppAssets.moodNeutral),
    MoodOption(label: 'Good', assetPath: AppAssets.moodGood),
    MoodOption(label: 'Very Good', assetPath: AppAssets.moodVeryGood),
  ];

  void selectMood(int index) => selectedMoodIndex.value = index;

  void startToday() => Get.toNamed(AppRoutes.youthMoodCheckIn);

  void openWeeklyProgress() => Get.toNamed(AppRoutes.youthWeekly);

  void onDailyTab(int index) => FlowNavigation.daily(0, index);

  void selectNavigationItem(int index) {
    FlowNavigation.youth(currentNavigationIndex.value, index);
  }
}
