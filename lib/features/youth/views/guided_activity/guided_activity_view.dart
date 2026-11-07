import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'guided_activity_controller.dart';

class GuidedActivityView extends GetView<GuidedActivityController> {
  const GuidedActivityView({super.key});

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
                'Guided Activity',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            DailyTabs(currentIndex: 3, onTap: controller.onDailyTab),
            const SizedBox(height: 26),
            Center(
              child: Text(
                'Take This At Your Own Pace.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: 258,
                height: 258,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircularProgressIndicator(
                      value: .75,
                      strokeWidth: 24,
                      color: Color(0xFFF9B83F),
                      backgroundColor: Color(0xFFF5F5F5),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '2:30',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(fontSize: 36),
                        ),
                        Text(
                          'Sec',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.ink.withValues(alpha: .4),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.outlined(
                  onPressed: controller.previousStep,
                  tooltip: 'Previous step',
                  icon: const Icon(Icons.skip_previous),
                ),
                const SizedBox(width: 16),
                Obx(
                  () => IconButton.filled(
                    onPressed: controller.togglePlayback,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.ink.withValues(alpha: .78),
                      fixedSize: const Size(60, 60),
                    ),
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton.outlined(
                  onPressed: controller.nextStep,
                  tooltip: 'Next step',
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Obx(
              () => Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.ink.withValues(alpha: .15),
                  ),
                ),
                child: Text(
                  '${controller.currentStep.value + 1}. ${const ['Sit comfortably with your feet on the floor.', 'Take a slow breath in through your nose.', 'Gently release the breath through your mouth.', 'Notice how your body feels.'][controller.currentStep.value]}',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.finish,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                    ),
                    child: const Text('Skip'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: controller.finish,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      backgroundColor: AppColors.ink.withValues(alpha: .78),
                    ),
                    child: const Text('Mark As Complete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
