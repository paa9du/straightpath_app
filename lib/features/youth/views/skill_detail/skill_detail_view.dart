import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/common/screen_header.dart';
import '../../../../shared/widgets/common/app_press_effect.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'skill_detail_controller.dart';

class SkillDetailView extends GetView<SkillDetailController> {
  const SkillDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      (
        'Box Breathing',
        'Breathe in, hold, breathe out, and hold for four counts.',
        Icons.air,
      ),
      (
        '5–4–3–2–1',
        'Use your senses to reconnect with the present moment.',
        Icons.visibility_outlined,
      ),
      (
        'Body Scan',
        'Slowly notice and relax each part of your body.',
        Icons.self_improvement,
      ),
      (
        'Thought Reset',
        'Name the thought, pause, and choose a kinder response.',
        Icons.refresh,
      ),
    ];
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 2,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          children: [
            ScreenHeader(title: controller.title, onBack: Get.back),
            Container(
              constraints: const BoxConstraints(minHeight: 150),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFE9B8), Color(0xFFFFC8CB)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${controller.title} Your Mind',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose a short exercise and take it at your own pace.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(exercises.length, (index) {
              final exercise = exercises[index];
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: AppPressEffect(
                    child: Material(
                      color: AppColors.cream,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: controller.selected.value == index
                              ? AppColors.coral
                              : AppColors.ink.withValues(alpha: .14),
                          width: controller.selected.value == index ? 2 : 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => controller.choose(index),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: const Color(0xFFFFE4D0),
                                child: Icon(exercise.$3, color: AppColors.ink),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise.$1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      exercise.$2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: Get.back,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Start Exercise'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
                backgroundColor: AppColors.ink.withValues(alpha: .78),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
