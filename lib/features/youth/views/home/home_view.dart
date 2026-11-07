import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/cards/progress_tracker.dart';
import '../../../../shared/widgets/navigation/app_bottom_navigation.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import 'home_controller.dart';
import 'widgets/mood_selector.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _navItems = [
    AppNavItem(label: 'Today', iconAsset: AppAssets.home),
    AppNavItem(label: 'Weekly', iconAsset: AppAssets.calendar),
    AppNavItem(label: 'Skills', iconAsset: AppAssets.skills),
    AppNavItem(label: 'Message', iconAsset: AppAssets.message),
    AppNavItem(label: 'Profile', iconAsset: AppAssets.profile),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                  children: [
                    _UserHeader(),
                    const SizedBox(height: 20),
                    DailyTabs(currentIndex: 0, onTap: controller.onDailyTab),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Course Progress',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: controller.openWeeklyProgress,
                          child: const Text('See More'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const _CourseProgressCard(),
                    const SizedBox(height: 24),
                    Text(
                      'Mood Check-In',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 9),
                    Obx(
                      () => MoodSelector(
                        moods: controller.moods,
                        selectedIndex: controller.selectedMoodIndex.value,
                        onSelected: controller.selectMood,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Daily Progress Tracker',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 9),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.ink.withValues(alpha: .12),
                        ),
                      ),
                      child: const ProgressTracker(
                        labels: ['Check-In', 'Focus', 'Activity', 'Reflection'],
                        completedSteps: 1,
                      ),
                    ),
                    const SizedBox(height: 18),
                    AppPrimaryButton(
                      label: 'Start Today',
                      gradient: true,
                      onPressed: controller.startToday,
                    ),
                  ],
                ),
              ),
              Obx(
                () => AppBottomNavigation(
                  items: _navItems,
                  currentIndex: controller.currentNavigationIndex.value,
                  onTap: controller.selectNavigationItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            AppAssets.youthAvatar,
            width: 42,
            height: 42,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Michael Thompson',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text.rich(
                const TextSpan(
                  children: [
                    TextSpan(text: 'Current Program: '),
                    TextSpan(
                      text: 'Behavioral Health',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: AppColors.ink.withValues(alpha: .55)),
              ),
            ],
          ),
        ),
        Text(
          'Wed, 21 Jan',
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: AppColors.ink.withValues(alpha: .45)),
        ),
      ],
    );
  }
}

class _CourseProgressCard extends StatelessWidget {
  const _CourseProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ink.withValues(alpha: .16)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 62,
                height: 62,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: .4,
                      strokeWidth: 7,
                      color: const Color(0xFFFF8B8F),
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      '40%',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              ...['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'].map(
                (day) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ['Mo', 'Tu', 'We'].contains(day)
                          ? const Color(0xFF9AE66E)
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Text(
                      day,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                'Week 1: ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.coral,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Expanded(
                child: Text(
                  'Emotional Regulation',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '23 Jan - 29 Jan',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: AppColors.ink.withValues(alpha: .35)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Continue →',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
