import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'focus_controller.dart';

class FocusView extends GetView<FocusController> {
  const FocusView({super.key});

  static const sections = [
    (
      'Stress',
      'Noticing Stress Without Judgment',
      'Stress can show up in many ways. Sometimes it feels loud—like tension, restlessness, or worry. Other times, it’s quiet, sitting in the background while you try to get through the day.\n\nToday’s focus is simply to notice stress when it appears. You don’t need to fix it or push it away. Just recognizing it creates a small pause, and that pause can make things feel a little more manageable.\n\nIf you find yourself thinking, “I shouldn’t feel like this,” gently let that thought go. Stress isn’t a weakness. It’s a signal that something inside you is asking for care.\n\nAs you move through today, check in once or twice. Ask yourself: What am I noticing right now? Awareness alone is a meaningful step.',
    ),
    (
      'Anger',
      'Understanding Anger As Information',
      'Anger often gets labeled as a “bad” emotion, but it is really information. It can show up when something feels unfair, unsafe, or out of your control. Notice it without judging it and give yourself time before reacting.',
    ),
    (
      'Motivation',
      'Finding Small Reasons To Begin',
      'Motivation does not always arrive as energy or excitement. A small action can come first, and motivation can follow later.',
    ),
    (
      'Focus',
      'Bringing Attention Back Gently',
      'Focus is about noticing when attention drifts and bringing it back without frustration. Each return matters.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 0,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          children: [
            Center(
              child: Text(
                'Focus',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            DailyTabs(currentIndex: 2, onTap: controller.onDailyTab),
            const SizedBox(height: 20),
            ...sections.map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFF1D9), Color(0xFFFFD9DC)],
                        ),
                      ),
                      child: Text(
                        section.$1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.ink.withValues(alpha: .16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.$2,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            section.$3,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.ink.withValues(alpha: .72),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
