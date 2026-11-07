import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import 'program_overview_controller.dart';

class ProgramOverviewView extends GetView<ProgramOverviewController> {
  const ProgramOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: AppBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
              child: Column(
                children: [
                  Text(
                    'Program Overview',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: ListView(
                      children: [
                        _OverviewCard(
                          title: 'Primary Goal',
                          child: Text(
                            'Help users understand what this program is, how it works, and what is expected, without overwhelming them or triggering resistance.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _OverviewCard(
                          title: 'Welcome To Straight Path',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'A structured path for growth, accountability, and support',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const Divider(height: 30),
                              const _OverviewSection(
                                title: 'Section 1 — What This Is',
                                body: 'Straight Path is a guided program that works alongside your in-person coaching. Each day and week is structured to help you build skills, reflect on your actions, and stay on track. This app is not social media. It is a focused space for learning, growth, and progress.',
                              ),
                              const Divider(height: 30),
                              const _OverviewSection(
                                title: 'Section 2 — How The Program Works',
                                body: 'Straight Path works alongside your in-person coaching with clear weekly topics, short daily activities, private participation, and coach support.',
                              ),
                              const SizedBox(height: 12),
                              const _NumberedItem(
                                number: '1',
                                title: 'Weekly Focus',
                                subtitle:
                                    'Each week has a clear topic and goal.',
                              ),
                              const SizedBox(height: 10),
                              const _NumberedItem(
                                number: '2',
                                title: 'Daily Activities',
                                subtitle: 'Short, guided steps you complete each day.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Get Started',
                      onPressed: controller.getStarted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(color: AppColors.coral),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _OverviewSection extends StatelessWidget {
  const _OverviewSection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(body, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _NumberedItem extends StatelessWidget {
  const _NumberedItem({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: const Color(0xFFFFE982),
          child: Text(number, style: const TextStyle(color: AppColors.ink)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
