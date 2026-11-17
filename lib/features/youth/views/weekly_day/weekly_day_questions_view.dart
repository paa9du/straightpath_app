import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/mock/mock_weeks.dart';
import '../../../../shared/widgets/common/figma_frame.dart';
import '../../../../shared/widgets/common/screen_header.dart';
import 'weekly_day_questions_controller.dart';
import 'weekly_day_widgets.dart';

abstract final class _C {
  static const heading = Color(0xFF0B192C);
  static const subtitle = Color(0xFF55697D);
  static const prompt = Color(0xFF718295);
  static const badgeBg = Color(0xFFDCF2ED);
  static const badgeText = Color(0xFF006E67);
  static const cardBorder = Color(0xFFEDF1F5);
}

/// Day questions (Figma 760:2093, screen 149).
class WeeklyDayQuestionsView extends GetView<WeeklyDayQuestionsController> {
  const WeeklyDayQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: FigmaFrame(
            child: Obx(() {
            final part = controller.part;
            final partIndex = controller.partIndex.value;
            final questionIndex = controller.questionIndex.value;
            final expanded = controller.expanded.value;
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(22, 4, 22, 16),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      ScreenHeader(
                        title: 'Week ${controller.week.number}',
                        onBack: controller.back,
                      ),
                      const SizedBox(height: 12),
                      WeeklyDayHeading(
                        date: controller.dateLabel,
                        title: controller.day.title,
                        description: controller.day.description,
                      ),
                      const SizedBox(height: 20),
                      // Figma 760:2111
                      WeeklyStatusCard(
                        height: 78,
                        child: Row(
                          children: [
                            const SizedBox(width: 11),
                            SvgPicture.asset(
                              AppAssets.questionsCalendar,
                              width: 41,
                              height: 41,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Complete ${part.questions.length} Questions',
                                    style: weeklyText(
                                      16.54,
                                      weight: FontWeight.w700,
                                      color: _C.heading,
                                      height: 22.75 / 16.54,
                                    ),
                                  ),
                                  Text(
                                    'Take a few minutes to reflect.',
                                    style: weeklyText(
                                      12,
                                      color: _C.subtitle,
                                      height: 20.67 / 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        part.title,
                        style: weeklyText(
                          22,
                          weight: FontWeight.w700,
                          color: WeeklyColors.navy,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _QuestionCard(
                        key: ValueKey('$partIndex-$questionIndex'),
                        number: questionIndex + 1,
                        question: controller.question,
                        controller: controller.answer,
                        expanded: expanded,
                        onToggle: controller.toggleQuestion,
                      ),
                    ],
                  ),
                ),
                WeeklyBottomButton(
                  label: 'Submit & Continue',
                  onPressed: controller.submit,
                ),
              ],
            );
          }),
          ),
        ),
      ),
    );
  }
}

/// Question card (Figma 760:2207).
class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.number,
    required this.question,
    required this.controller,
    required this.expanded,
    required this.onToggle,
    super.key,
  });

  final int number;
  final DayQuestion question;
  final TextEditingController controller;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(17.64, 17.64, 17.74, expanded ? 29 : 17.64),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.64),
        border: Border.all(color: _C.cardBorder, width: 1.1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, 2.2),
            blurRadius: 5.51,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onToggle,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.2),
                  child: Container(
                    width: 30.87,
                    height: 30.87,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: _C.badgeBg,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$number',
                      style: weeklyText(
                        15.44,
                        weight: FontWeight.w700,
                        color: _C.badgeText,
                        height: 22.05 / 15.44,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 13.23),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.title,
                        style: weeklyText(
                          16.54,
                          weight: FontWeight.w700,
                          color: _C.heading,
                          height: 20.67 / 16.54,
                        ),
                      ),
                      const SizedBox(height: 5.2),
                      Text(
                        question.prompt,
                        style: weeklyText(
                          13.23,
                          color: _C.prompt,
                          height: 17.64 / 13.23,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.41),
                  child: SvgPicture.asset(
                    AppAssets.questionChevron,
                    width: 17.64,
                    height: 17.64,
                  ),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            alignment: Alignment.topCenter,
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.only(top: 18.6),
                    child: SizedBox(
                      height: 232,
                      child: TextField(
                        controller: controller,
                        expands: true,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        textCapitalization: TextCapitalization.sentences,
                        style: weeklyText(15, color: AppColors.ink),
                        decoration: InputDecoration(
                          hintText: 'Write Your Answer Here...',
                          hintStyle: weeklyText(
                            15,
                            color: AppColors.ink.withValues(alpha: .4),
                          ),
                          filled: true,
                          fillColor: AppColors.cream,
                          contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.ink.withValues(alpha: .1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.ink.withValues(alpha: .25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
