import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/title_case.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'focus_controller.dart';

class FocusView extends GetView<FocusController> {
  const FocusView({super.key});

  // Figma 247:1005 – (section band, card heading, card body).
  static const sections = [
    (
      'Stress',
      'Noticing Stress Without Judgment',
      'Stress can show up in many ways.\nSometimes it feels loud—like tension, restlessness, or worry. Other times, it\'s quiet, sitting in the background while you try to get through the day.\n\nToday\'s focus is simply to notice stress when it appears.\nYou don\'t need to fix it or push it away. Just recognizing it creates a small pause, and that pause can make things feel a little more manageable.\n\nIf you find yourself thinking, "I shouldn\'t feel like this," gently let that thought go. Stress isn\'t a weakness. It\'s a signal that something inside you is asking for care.\n\nAs you move through today, check in once or twice.\nAsk yourself: What am I noticing right now?\nAwareness alone is a meaningful step.',
    ),
    (
      'Anger',
      'Understanding Anger As Information',
      'Anger often gets labeled as a "bad" emotion, but it\'s really just information.\nIt can show up when something feels unfair, unsafe, or out of your control.\n\nToday\'s focus is to notice anger without judging it.\nYou don\'t have to act on it, and you don\'t have to suppress it. Simply noticing where it lives in your body or thoughts can help slow things down.\n\nIf anger feels intense, that doesn\'t mean you\'re doing something wrong.\nIt means something matters to you. Listening to that message—without reacting—gives you more choice in what comes next.\n\nAs the day goes on, try asking:\nWhat is this feeling trying to tell me?\nYou don\'t need an answer right away. Noticing is enough.',
    ),
    (
      'Motivation',
      'Finding Small Reasons To Begin',
      'Motivation doesn\'t always arrive as energy or excitement.\nSometimes it shows up quietly—or not at all—and that can make starting feel difficult.\n\nToday\'s focus is on taking small steps, even when motivation feels low.\nYou don\'t need to feel ready. Action can come first, and motivation can follow later.\n\nIf you notice thoughts like, "What\'s the point?" or "I can\'t do this," pause and soften them. You\'re not failing. You\'re human, and starting small still counts.\n\nAs you move through today, look for one simple reason to begin—just one.\nA small step is still movement forward.',
    ),
    (
      'Focus',
      'Bringing Attention Back Gently',
      'Focus isn\'t about forcing your mind to stay still.\nIt\'s about noticing when your attention drifts—and bringing it back without frustration.\n\nToday\'s focus is to practice returning your attention gently.\nWhen your thoughts wander, that\'s not a mistake. It\'s part of how the mind works.\n\nEach time you notice distraction and come back to what you\'re doing, you\'re building focus. Even if it happens many times, each return matters.\n\nAs you go through today, try this question:\nWhere is my attention right now?\nNo judgment—just noticing and returning.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 0,
        onNavigationTap: controller.onNavigationTap,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Focus',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DailyTabs(currentIndex: 2, onTap: controller.onDailyTab),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                children: [
                  for (final section in sections)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _FocusSection(
                        band: section.$1,
                        heading: section.$2,
                        body: section.$3,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Figma 316:653 – 28px gradient band with 18 semibold title, 1px rule 10px
/// below it, then a cream card 10px under the rule.
class _FocusSection extends StatelessWidget {
  const _FocusSection({
    required this.band,
    required this.heading,
    required this.body,
  });

  final String band;
  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withNoTextScaling(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x33F5B84A), Color(0x33FF6464)],
              ),
            ),
            child: Text(
              titleCase(band),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: AppColors.ink.withValues(alpha: .1)),
          const SizedBox(height: 9),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.ink.withValues(alpha: .1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink.withValues(alpha: .8),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  titleCase(body),
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 13,
                    height: 20 / 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink.withValues(alpha: .6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
