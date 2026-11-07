import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_interaction_feedback.dart';
import '../../../../shared/widgets/common/screen_header.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'weekly_detail_controller.dart';

class WeeklyDetailView extends GetView<WeeklyDetailController> {
  const WeeklyDetailView({super.key});

  static const lessons = [
    (
      'Day 1',
      'Notice What You Feel',
      'Recognize emotions without judging them.',
    ),
    (
      'Day 2',
      'Name The Feeling',
      'Put simple words to what is happening inside.',
    ),
    (
      'Day 3',
      'Pause Before Reacting',
      'Create a little space before your next action.',
    ),
    (
      'Day 4',
      'Understand The Trigger',
      'Explore what may have brought the feeling up.',
    ),
    (
      'Day 5',
      'Choose A Healthy Response',
      'Practice a calm and useful next step.',
    ),
    ('Day 6', 'Reflect And Reset', 'Review what worked and begin again.'),
    (
      'Day 7',
      'Celebrate Your Progress',
      'Notice the effort you made this week.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 1,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          children: [
            ScreenHeader(title: 'Week ${controller.week}', onBack: Get.back),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFE6B9), Color(0xFFFFC8CC)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emotional Regulation',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Develop awareness of emotions as they arise, without judgment.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  const LinearProgressIndicator(
                    value: .4,
                    minHeight: 8,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.coral,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  const Text('3 of 7 days completed'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(lessons.length, (index) {
              final item = lessons[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => AppInteractionFeedback.showSelection(
                    context,
                    '${item.$1}: ${item.$2}',
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.ink.withValues(alpha: .14),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index < 3
                                ? const Color(0xFF9AE66E)
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: Icon(
                            index < 3 ? Icons.check : Icons.lock_open_rounded,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.$1,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                item.$2,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                item.$3,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
