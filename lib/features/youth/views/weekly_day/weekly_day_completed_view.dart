import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../data/mock/mock_weeks.dart';
import '../../../../shared/widgets/common/figma_frame.dart';
import '../../../../shared/widgets/common/screen_header.dart';
import 'weekly_day_completed_controller.dart';
import 'weekly_day_widgets.dart';

abstract final class _C {
  static const checkGreen = Color(0xFF22B087);
  static const slate500 = Color(0xFF64748B);
  static const slate400 = Color(0xFF94A3B8);
  static const muted = Color(0xFF627D8C);
  static const chipCheck = Color(0xFF00A887);
  static const numberBg = Color(0xB3D5F1E9);
  static const doneBg = Color(0xFFB8EBD9);
  static const insightBg = Color(0xFFE4F7F4);
  static const insightBorder = Color(0x80CCFBF1);
  static const insightDivider = Color(0xCCB4B4B4);
}

/// Completed day (Figma 757:1762, screen 148).
class WeeklyDayCompletedView extends GetView<WeeklyDayCompletedController> {
  const WeeklyDayCompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    final parts = controller.day.parts;
    return ResponsiveLayout(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: FigmaFrame(
            child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 4, 22, 24),
            children: [
              ScreenHeader(
                title: 'Week ${controller.week.number}',
                onBack: Get.back,
              ),
              const SizedBox(height: 12),
              WeeklyDayHeading(
                date: controller.dateLabel,
                title: controller.day.title,
                description: controller.day.description,
              ),
              const SizedBox(height: 25),
              WeeklyStatusCard(
                height: 108,
                child: Row(
                  children: [
                    const SizedBox(width: 22),
                    Container(
                      width: 70.56,
                      height: 70.56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _C.checkGreen, width: 6),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.dayCompletedCheck,
                        width: 35.28,
                        height: 35.28,
                      ),
                    ),
                    const SizedBox(width: 21),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.dayName}'s Activity",
                            style: weeklyText(14.33, color: _C.slate500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Completed!',
                            style: weeklyText(
                              22.05,
                              weight: FontWeight.w700,
                              color: WeeklyColors.navy,
                              letterSpacing: -0.55,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Great job for taking this step.',
                            style: weeklyText(13.23, color: _C.muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    'Questions (${parts.length})',
                    style: weeklyText(
                      17,
                      weight: FontWeight.w600,
                      color: WeeklyColors.navy,
                    ),
                  ),
                  const Spacer(),
                  _CompletedChip(total: parts.length),
                ],
              ),
              const SizedBox(height: 10),
              for (var i = 0; i < parts.length; i++)
                Padding(
                  padding: EdgeInsets.only(top: i == 0 ? 0 : 8),
                  child: _PartTile(number: i + 1, part: parts[i]),
                ),
              const SizedBox(height: 17),
              _KeyInsightCard(text: controller.insight),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

/// "4 / 4 Completed" chip (Figma 757:1896).
class _CompletedChip extends StatelessWidget {
  const _CompletedChip({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.82,
      padding: const EdgeInsets.only(left: 13.23, right: 13.23),
      decoration: BoxDecoration(
        color: WeeklyColors.dateBadge,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 17.64,
            height: 17.64,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _C.chipCheck,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.chipCheck,
              width: 11.03,
              height: 11.03,
            ),
          ),
          const SizedBox(width: 6.62),
          Text(
            '$total / $total Completed',
            style: weeklyText(
              13,
              weight: FontWeight.w700,
              color: WeeklyColors.dateBadgeText,
              height: 17.64 / 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// Part row (Figma 757:1905): 73 tall, white, number badge, done check.
class _PartTile extends StatelessWidget {
  const _PartTile({required this.number, required this.part});

  final int number;
  final DayPart part;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.64),
        border: Border.all(color: WeeklyColors.cardBorder, width: 1.1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, 2.2),
            blurRadius: 4.41,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 11.9),
          Container(
            width: 35.28,
            height: 35.28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _C.numberBg,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: weeklyText(
                15.44,
                weight: FontWeight.w700,
                color: WeeklyColors.dateBadgeText,
                height: 22.05 / 15.44,
              ),
            ),
          ),
          const SizedBox(width: 19.8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  part.title,
                  maxLines: 1,
                  softWrap: false,
                  style: weeklyText(
                    14.89,
                    weight: FontWeight.w600,
                    color: WeeklyColors.navy,
                    height: 18.61 / 14.89,
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${part.answers} answers',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: ' • ${part.minutes} min'),
                    ],
                  ),
                  style: weeklyText(13.23, color: _C.slate400),
                ),
              ],
            ),
          ),
          Container(
            width: 26.46,
            height: 26.46,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _C.doneBg,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.partDoneCheck,
              width: 15.44,
              height: 15.44,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

/// Key Insight card (Figma 757:1849): bulb, grey divider, title + text.
class _KeyInsightCard extends StatelessWidget {
  const _KeyInsightCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 97),
      padding: const EdgeInsets.symmetric(vertical: 11.64),
      decoration: BoxDecoration(
        color: _C.insightBg,
        borderRadius: BorderRadius.circular(17.64),
        border: Border.all(color: _C.insightBorder, width: 1.1),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 79.38,
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.keyInsightBulb,
                  width: 30.87,
                  height: 30.87,
                ),
              ),
            ),
            Container(width: 1.1, color: _C.insightDivider),
            const SizedBox(width: 17.64),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 2, bottom: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Insight',
                      style: weeklyText(
                        15.44,
                        weight: FontWeight.w700,
                        color: WeeklyColors.navy,
                        height: 22.05 / 15.44,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      text,
                      style: weeklyText(
                        13.23,
                        color: _C.muted,
                        height: 21.5 / 13.23,
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
