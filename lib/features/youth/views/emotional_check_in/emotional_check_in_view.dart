import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'emotional_check_in_controller.dart';

class EmotionalCheckInView extends GetView<EmotionalCheckInController> {
  const EmotionalCheckInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 0,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
          children: [
            Center(
              child: Text(
                'Emotional Check-In',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            DailyTabs(currentIndex: 1, onTap: controller.onDailyTab),
            const SizedBox(height: 24),
            Text(
              'How Are You Feeling Right Now?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 14),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 112,
                mainAxisSpacing: 10,
                crossAxisSpacing: 14,
              ),
              itemCount: controller.feelings.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final feeling = controller.feelings[index];
                  final active =
                      controller.selectedFeeling.value == feeling.label;
                  return InkWell(
                    onTap: () => controller.selectFeeling(feeling.label),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.yellow.withValues(alpha: .38)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: active
                              ? AppColors.coral
                              : AppColors.ink.withValues(alpha: .15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            feeling.emoji,
                            style: const TextStyle(fontSize: 38, height: 1),
                          ),
                          const SizedBox(height: 4),
                          Text(feeling.label),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 22),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'What’s Influencing This Feeling? '),
                  TextSpan(
                    text: '(Optional)',
                    style: TextStyle(
                      color: AppColors.ink.withValues(alpha: .35),
                    ),
                  ),
                ],
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Add A Note Here...',
                fillColor: AppColors.cream,
              ),
            ),
            const SizedBox(height: 16),
            AppPrimaryButton(
              label: 'Continue',
              onPressed: controller.continueFlow,
            ),
          ],
        ),
      ),
    );
  }
}
