import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_interaction_feedback.dart';
import '../../models/person_summary.dart';
import '../cards/progress_tracker.dart';
import 'screen_header.dart';

class YouthDetailContent extends StatelessWidget {
  const YouthDetailContent({
    required this.person,
    required this.onBack,
    required this.onOpenNotes,
    required this.onOpenChat,
    super.key,
  });

  final PersonSummary person;
  final VoidCallback onBack;
  final VoidCallback onOpenNotes;
  final VoidCallback onOpenChat;

  @override
  Widget build(BuildContext context) {
    const moods = [
      (AppAssets.moodVeryBad, 'Very Bad'),
      (AppAssets.moodSad, 'Sad'),
      (AppAssets.moodNeutral, 'Neutral'),
      (AppAssets.moodGood, 'Good'),
      (AppAssets.moodVeryGood, 'Very Good'),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      children: [
        ScreenHeader(
          title: person.name,
          onBack: onBack,
          trailing: IconButton(
            onPressed: onOpenChat,
            icon: const Icon(Icons.chat_bubble_outline),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.ink.withValues(alpha: .18)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      person.imagePath,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          person.program,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.ink.withValues(alpha: .48),
                              ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: onOpenNotes,
                    child: const Text('Explore ›'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Status: ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: person.statusDate),
                  ],
                ),
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: AppColors.ink.withValues(alpha: .5)),
              ),
              const SizedBox(height: 20),
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
                    onPressed: () => AppInteractionFeedback.showSelection(
                      context,
                      'Course Progress',
                    ),
                    child: const Text('See More'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.ink.withValues(alpha: .15),
                  ),
                  borderRadius: BorderRadius.circular(16),
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
                              const CircularProgressIndicator(
                                value: .4,
                                strokeWidth: 7,
                                color: Color(0xFFFF8B8F),
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
                        const SizedBox(width: 14),
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Week 1: ',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.coral,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const Expanded(
                          child: Text(
                            'Emotional Regulation',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          '23 Jan - 29 Jan',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.ink.withValues(alpha: .35),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Mood Check-In',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 9),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD799), Color(0xFFFFA4AA)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: moods
                          .map(
                            (mood) => SizedBox(
                              width: 60,
                              child: Column(
                                children: [
                                  Image.asset(mood.$1, width: 48, height: 48),
                                  Text(
                                    mood.$2,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .82),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text.rich(
                        const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Last Check-In: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: 'Good 🙂',
                              style: TextStyle(
                                color: AppColors.success,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Daily Progress Tracker',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 9),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.ink.withValues(alpha: .15),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ProgressTracker(
                  labels: ['Check-In', 'Focus', 'Activity', 'Reflection'],
                  completedSteps: 1,
                  compact: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
