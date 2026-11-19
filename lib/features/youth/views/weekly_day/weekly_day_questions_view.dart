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
  static const prompt = Color(0xFF718295);
  static const badgeBg = Color(0xFFDCF2ED);
  static const badgeText = Color(0xFF006E67);
  static const cardBorder = Color(0xFFEDF1F5);
}

/// Day worksheet, one screen per part (Figma 760:2093 Part A, 878:3423
/// Part B, 878:3508 Part C, 878:3580 Part D).
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
              final fields = controller.partFields;
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: controller.scroll,
                      padding: const EdgeInsets.fromLTRB(22, 4, 22, 16),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      children: [
                        // Figma 878:3438
                        ScreenHeader(
                          title: controller.title,
                          onBack: controller.back,
                        ),
                        const SizedBox(height: 12),
                        // Figma 878:3441: date badge, day title, description.
                        WeeklyDayHeading(
                          date: controller.dateLabel,
                          title: controller.day.title,
                          description: controller.day.description,
                        ),
                        const SizedBox(height: 45),
                        Text(
                          part.worksheetTitle,
                          style: weeklyText(
                            22,
                            weight: FontWeight.w700,
                            color: WeeklyColors.navy,
                          ),
                        ),
                        const SizedBox(height: 10),
                        for (var i = 0; i < part.questions.length; i++) ...[
                          // Figma 878:3610 / 3727: 12 between cards.
                          if (i > 0) const SizedBox(height: 12),
                          _QuestionCard(
                            key: ValueKey('$partIndex-$i'),
                            number: i + 1,
                            question: part.questions[i],
                            fields: fields[i],
                            expanded: controller.isExpanded(i),
                            onToggle: () => controller.toggleQuestion(i),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Figma 760:2299 "Next", 878:3763 "Submit & Continue".
                  WeeklyBottomButton(
                    label: controller.isLastPart ? 'Submit & Continue' : 'Next',
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

/// Question card (Figma 849:1242, 878:3610): header at 24.9 / 16.9, answer
/// boxes 19 from the card edges. List questions show 54px one-line boxes;
/// open questions (no subtitle) show one 116px box.
class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.number,
    required this.question,
    required this.fields,
    required this.expanded,
    required this.onToggle,
    super.key,
  });

  final int number;
  final DayQuestion question;
  final List<TextEditingController> fields;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final single = fields.length == 1;
    final bottom = !expanded ? 24.9 : (single ? 34.0 : 32.74);
    return Container(
      padding: EdgeInsets.fromLTRB(16.9, 24.9, 18.49, bottom),
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
                      if (question.prompt.isNotEmpty) ...[
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
                    // Figma: boxes start 86.3 into the card under a
                    // title + subtitle, 91 under a two-line title.
                    padding: EdgeInsets.fromLTRB(
                      2.1,
                      question.prompt.isEmpty ? 24.8 : 18.6,
                      0.51,
                      0,
                    ),
                    child: single
                        ? SizedBox(
                            height: 116,
                            child: _AnswerField(
                              controller: fields.first,
                              multiline: true,
                            ),
                          )
                        : Column(
                            children: [
                              for (var i = 0; i < fields.length; i++) ...[
                                if (i > 0) const SizedBox(height: 6),
                                SizedBox(
                                  height: 54,
                                  child: _AnswerField(
                                    controller: fields[i],
                                    last: i == fields.length - 1,
                                  ),
                                ),
                              ],
                            ],
                          ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

/// Answer box (Figma 849:1258): cream, ink 10% border, 16 radius,
/// Medium 15 hint at ink 40% inset 19.3.
class _AnswerField extends StatelessWidget {
  const _AnswerField({
    required this.controller,
    this.multiline = false,
    this.last = true,
  });

  final TextEditingController controller;
  final bool multiline;
  final bool last;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(double alpha) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.ink.withValues(alpha: alpha)),
    );
    return TextField(
      controller: controller,
      expands: multiline,
      maxLines: multiline ? null : 1,
      textAlignVertical: multiline
          ? TextAlignVertical.top
          : TextAlignVertical.center,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: multiline || last
          ? TextInputAction.done
          : TextInputAction.next,
      style: weeklyText(15, color: AppColors.ink),
      decoration: InputDecoration(
        hintText: 'Write Your Answer Here...',
        hintStyle: weeklyText(15, color: AppColors.ink.withValues(alpha: .4)),
        filled: true,
        fillColor: AppColors.cream,
        // Figma 878:3724: hint 14 from the top and 16 from the left of the
        // 116px box; 849:1258: 19.3 from the left of the 54px box.
        contentPadding: multiline
            ? const EdgeInsets.fromLTRB(16, 14, 16, 14)
            : const EdgeInsets.symmetric(horizontal: 19.26),
        enabledBorder: border(.1),
        focusedBorder: border(.25),
      ),
    );
  }
}
