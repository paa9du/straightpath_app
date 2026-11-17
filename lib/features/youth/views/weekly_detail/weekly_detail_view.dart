import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/title_case.dart';
import '../../../../data/mock/mock_weeks.dart';
import '../../../../shared/widgets/common/figma_frame.dart';
import '../../../../shared/widgets/common/screen_header.dart';
import '../weekly_day/weekly_day_widgets.dart';
import 'weekly_detail_controller.dart';

/// Figma 147 colours (Tailwind slate / teal).
abstract final class _C {
  static const slate900 = Color(0xFF0F172A);
  static const slate700 = Color(0xFF334155);
  static const slate600 = Color(0xFF475569);
  static const teal500 = Color(0xFF14B8A6);
  static const teal800 = Color(0xFF115E59);
  static const pillBorder = Color(0xFFF1F5F9);
  static const pastPill = Color(0xFFB6F0E2);
  static const todayPill = Color(0xFFF0E5B6);
  static const weekendPill = Color(0xFFEDEBEB);
  static const goalsIconBg = Color(0xFFF0FDFA);
  static const progressBg = Color(0xFFE4F7F4);
}

/// Week overview (Figma 754:1247, screen 147). Laid out on the 430px
/// Figma frame and scaled to the phone width by [FigmaFrame].
class WeeklyDetailView extends GetView<WeeklyDetailController> {
  const WeeklyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final week = controller.week;
    return ResponsiveLayout(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: FigmaFrame(
            child: Obx(() {
              final done = controller.completedDays;
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(22, 4, 22, 16),
                      children: [
                        ScreenHeader(
                          title: 'Week ${week.number}',
                          onBack: Get.back,
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: _WeekSummary(
                            week: week,
                            progress: controller.progress,
                          ),
                        ),
                        const SizedBox(height: 23),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < 7; i++)
                                _DayPill(
                                  label: weekDayShortNames[i],
                                  status: controller.statusOf(i),
                                  onTap: controller.isSelectable(i)
                                      ? () => controller.selectDay(i)
                                      : null,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 27),
                        _OverviewCard(week: week),
                        const SizedBox(height: 23),
                        _GoalsCard(goals: week.goals),
                        const SizedBox(height: 28),
                        _ProgressCard(week: week.number, completedDays: done),
                      ],
                    ),
                  ),
                  WeeklyBottomButton(
                    label: 'Continue',
                    onPressed: controller.continueTap,
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

/// Ring + title block (Figma 755:1580).
class _WeekSummary extends StatelessWidget {
  const _WeekSummary({required this.week, required this.progress});

  final WeekContent week;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          height: 90,
          child: CustomPaint(
            painter: _RingPainter(progress),
            child: Center(
              child: Text(
                '${(progress * 100).round()}%',
                style: weeklyText(
                  17.73,
                  weight: FontWeight.w800,
                  color: AppColors.ink.withValues(alpha: .7),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                week.title,
                maxLines: 1,
                style: weeklyText(
                  19.85,
                  weight: FontWeight.w700,
                  color: _C.slate900,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 263,
                child: Text(
                  titleCase(week.description),
                  style: weeklyText(
                    14,
                    weight: FontWeight.w400,
                    color: _C.slate600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.weekCalendar,
                    width: 15.44,
                    height: 15.44,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    week.overviewDateRange,
                    maxLines: 1,
                    style: weeklyText(
                      13.23,
                      weight: FontWeight.w400,
                      color: _C.slate700,
                      height: 19.85 / 13.23,
                      letterSpacing: -0.33,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 11.0;
    final rect = Offset.zero & size;
    final arc = rect.deflate(stroke / 2);
    canvas.drawArc(
      arc,
      0,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = const Color(0xFFF3F3F3),
    );
    if (progress <= 0) return;
    canvas.drawArc(
      arc,
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..shader = const SweepGradient(
          colors: [Color(0xFFF5B84A), Color(0xFFFF7C82), Color(0xFFF5B84A)],
          transform: GradientRotation(-math.pi / 2),
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}

/// Day pill. Figma: 755:1553 past (mint), 755:1555 today (yellow),
/// 755:1557 upcoming (white), 755:1563 weekend (grey).
class _DayPill extends StatelessWidget {
  const _DayPill({
    required this.label,
    required this.status,
    required this.onTap,
  });

  final String label;
  final WeekDayStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg, FontWeight weight, bool border, double padX) =
        switch (status) {
          WeekDayStatus.past => (_C.pastPill, _C.slate900, FontWeight.w700, false, 12.0),
          WeekDayStatus.today => (_C.todayPill, _C.slate700, FontWeight.w700, true, 13.1),
          WeekDayStatus.upcoming => (Colors.white, _C.slate700, FontWeight.w700, true, 13.1),
          WeekDayStatus.weekend => (_C.weekendPill, _C.slate700, FontWeight.w500, true, 13.1),
        };
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 35.3,
        padding: EdgeInsets.symmetric(horizontal: padX),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          // No selection outline: pills look exactly like Figma.
          border: border ? Border.all(color: _C.pillBorder, width: 1.1) : null,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 1.1),
              blurRadius: 1.1,
            ),
          ],
        ),
        child: Text(
          label,
          style: weeklyText(
            13.23,
            weight: weight,
            color: fg,
            height: 17.64 / 13.23,
          ),
        ),
      ),
    );
  }
}

/// Week overview banner (Figma 756:1581): 380 x 144.
class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.week});

  final WeekContent week;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 144),
        padding: const EdgeInsets.fromLTRB(17.91, 13.91, 8.62, 16),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(17.37),
          border: Border.all(color: const Color(0x99CCFBF1), width: 1.09),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 1.09),
              blurRadius: 2.17,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Figma 756:1600: white 70% chip, bold teal-800 text.
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13.03,
                vertical: 4.34,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Week ${week.number} Overview',
                style: weeklyText(
                  11.94,
                  weight: FontWeight.w700,
                  color: _C.teal800,
                  height: 17.91 / 11.94,
                ),
              ),
            ),
            const SizedBox(height: 14.5),
            Text(
              week.overviewTitle,
              maxLines: 1,
              style: weeklyText(
                17.37,
                weight: FontWeight.w600,
                color: _C.slate900,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              week.overviewDescription,
              style: weeklyText(
                13.03,
                weight: FontWeight.w400,
                color: _C.slate700,
                height: 22 / 13.03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Your Goals card (Figma 756:1603): 386 wide.
class _GoalsCard extends StatelessWidget {
  const _GoalsCard({required this.goals});

  final List<String> goals;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17.64),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.64),
        border: Border.all(color: _C.pillBorder, width: 1.1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, 2.2),
            blurRadius: 6.6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 26.46,
            child: Row(
              children: [
                // Figma 756:1605: target icon on a teal-50 circle.
                Container(
                  width: 26.46,
                  height: 26.46,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: _C.goalsIconBg,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.goalsTarget,
                    width: 17.64,
                    height: 17.64,
                  ),
                ),
                const SizedBox(width: 11.03),
                Text(
                  'Your Goals',
                  style: weeklyText(
                    15.44,
                    weight: FontWeight.w600,
                    color: _C.slate900,
                    height: 22.05 / 15.44,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 13.23),
          for (var i = 0; i < goals.length; i++)
            Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : 13.23),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 17.64,
                    height: 17.64,
                    margin: const EdgeInsets.only(top: 2.2),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: _C.teal500,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.goalCheck,
                      width: 11.03,
                      height: 11.03,
                    ),
                  ),
                  const SizedBox(width: 13.23),
                  Expanded(
                    child: Text(
                      goals[i],
                      style: weeklyText(
                        13.23,
                        weight: FontWeight.w400,
                        color: _C.slate700,
                        height: 18.19 / 13.23,
                      ),
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

/// Great Progress card (Figma 756:1635) with the trophy (756:1636).
class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.week, required this.completedDays});

  final int week;
  final int completedDays;

  @override
  Widget build(BuildContext context) {
    final all = completedDays >= programDays;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.74),
      decoration: BoxDecoration(
        color: _C.progressBg,
        borderRadius: BorderRadius.circular(17.64),
        border: Border.all(color: const Color(0x80CCFBF1), width: 1.1),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70.56,
            height: 70.56,
            child: Center(
              child: Image.asset(AppAssets.trophy, width: 61.74, height: 61.74),
            ),
          ),
          const SizedBox(width: 17.64),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4.41),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Great Progress!',
                    style: weeklyText(
                      15.44,
                      weight: FontWeight.w700,
                      color: _C.slate900,
                      height: 22.05 / 15.44,
                    ),
                  ),
                  const SizedBox(height: 2.2),
                  Text(
                    all
                        ? "You've completed all activities for Week $week."
                        : "You've completed $completedDays of $programDays activities for Week $week.",
                    style: weeklyText(
                      13.23,
                      color: _C.slate700,
                      height: 18.19 / 13.23,
                    ),
                  ),
                  const SizedBox(height: 6.62),
                  Container(height: 1.1, color: const Color(0x9999F6E4)),
                  const SizedBox(height: 6.62),
                  Text(
                    all
                        ? 'Move forward to continue your journey.'
                        : "Finish today's activity to keep going.",
                    style: weeklyText(
                      12.13,
                      color: _C.slate600,
                      height: 18.19 / 12.13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
