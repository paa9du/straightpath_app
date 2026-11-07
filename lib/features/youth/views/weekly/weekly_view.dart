import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import '../../../../shared/widgets/common/app_press_effect.dart';
import 'weekly_controller.dart';
import 'weekly_model.dart';

class WeeklyView extends GetView<WeeklyController> {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 1,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          children: [
            Center(
              child: Text(
                'Weekly',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 20),
            ...controller.weeks.map(
              (week) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _WeekCard(
                  week: week,
                  onTap: () => controller.openWeek(week.week),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({required this.week, required this.onTap});

  final WeekProgress week;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return AppPressEffect(
      child: Material(
        elevation: 1,
        color: AppColors.cream,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.ink.withValues(alpha: .18)),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 68,
                      height: 68,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: week.progress,
                            strokeWidth: 7,
                            color: const Color(0xFFFF8D83),
                            backgroundColor: Colors.white,
                          ),
                          Text(
                            '${(week.progress * 100).round()}%',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(days.length, (index) {
                          final done = index < week.completedDays;
                          return Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: done
                                  ? const Color(0xFF9AE66E)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: done
                                    ? const Color(0xFF9AE66E)
                                    : AppColors.divider,
                              ),
                            ),
                            child: Text(
                              days[index],
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: done
                                        ? AppColors.ink
                                        : AppColors.ink.withValues(alpha: .28),
                                  ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Week ${week.week}: ',
                        style: const TextStyle(
                          color: AppColors.coral,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: week.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  week.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  week.dateRange,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: AppColors.ink.withValues(alpha: .35)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
