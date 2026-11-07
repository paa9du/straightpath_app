import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'reflection_controller.dart';

class ReflectionView extends GetView<ReflectionController> {
  const ReflectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 0,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 22),
          children: [
            Center(
              child: Text(
                'Reflection',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            DailyTabs(currentIndex: 4, onTap: controller.onDailyTab),
            const SizedBox(height: 28),
            Center(
              child: Text(
                'Take A Moment To Reflect',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'What stood out to you today? There is no right or wrong answer.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppColors.ink.withValues(alpha: .55)),
            ),
            const SizedBox(height: 22),
            Obx(
              () => SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Text('Text Note')),
                  ButtonSegment(value: 1, label: Text('Voice Note')),
                ],
                selected: {controller.mode.value},
                onSelectionChanged: (value) => controller.setMode(value.first),
                showSelectedIcon: false,
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: AppColors.peach,
                  selectedForegroundColor: AppColors.ink,
                  minimumSize: const Size.fromHeight(52),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: controller.mode.value == 0
                    ? TextField(
                        key: const ValueKey('text-note'),
                        controller: controller.noteController,
                        minLines: 9,
                        maxLines: 12,
                        decoration: InputDecoration(
                          hintText: 'Write your reflection here...',
                          filled: true,
                          fillColor: AppColors.cream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      )
                    : Container(
                        key: const ValueKey('voice-note'),
                        height: 248,
                        decoration: BoxDecoration(
                          color: AppColors.cream,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.ink.withValues(alpha: .16),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: controller.toggleRecording,
                              borderRadius: BorderRadius.circular(48),
                              child: Container(
                                width: 86,
                                height: 86,
                                decoration: const BoxDecoration(
                                  color: AppColors.coral,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  controller.isRecording.value
                                      ? Icons.stop_rounded
                                      : Icons.mic_rounded,
                                  color: Colors.white,
                                  size: 38,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              controller.isRecording.value
                                  ? 'Recording... tap to stop'
                                  : 'Tap To Start Recording',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '00:00',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: controller.submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
                backgroundColor: AppColors.ink.withValues(alpha: .78),
              ),
              child: const Text('Submit Reflection'),
            ),
          ],
        ),
      ),
    );
  }
}
