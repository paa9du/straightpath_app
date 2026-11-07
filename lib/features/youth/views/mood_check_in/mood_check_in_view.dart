import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/screen_header.dart';
import 'mood_check_in_controller.dart';

class MoodCheckInView extends GetView<MoodCheckInController> {
  const MoodCheckInView({super.key});

  static const moods = [
    (AppAssets.moodVeryGood, 'Very Good', '9-10', Color(0xFF3AC56D)),
    (AppAssets.moodGood, 'Good', '7-8', Color(0xFF70C144)),
    (AppAssets.moodNeutral, 'Neutral', '5-6', Color(0xFFD5C73F)),
    (AppAssets.moodSad, 'Sad', '3-4', Color(0xFFE99350)),
    (AppAssets.moodVeryBad, 'Very Bad', '1-2', Color(0xFFEA6271)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
            child: Column(
              children: [
                ScreenHeader(title: 'Mood Check-In', onBack: controller.back),
                const SizedBox(height: 18),
                Text(
                  'How Would You Describe\nYour Mood?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 34),
                Expanded(
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 24,
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.cream,
                                Color(0xFFFFD7A0),
                                Color(0xFFEE7580),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(moods.length, (index) {
                            final mood = moods[index];
                            final active =
                                controller.selectedIndex.value == index;
                            return InkWell(
                              onTap: () => controller.select(index),
                              borderRadius: BorderRadius.circular(14),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mood.$2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: active
                                                    ? FontWeight.w800
                                                    : FontWeight.w400,
                                              ),
                                        ),
                                        Text(
                                          '♡ ${mood.$3}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: mood.$4),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 160),
                                    width: active ? 68 : 60,
                                    height: active ? 68 : 60,
                                    child: Image.asset(mood.$1),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 180),
                          alignment: Alignment(
                            0,
                            -1 + (controller.selectedIndex.value * .5),
                          ),
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: moods[controller.selectedIndex.value].$4,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: AppPrimaryButton(
                    label: 'Mood Check-In',
                    onPressed: controller.continueFlow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
