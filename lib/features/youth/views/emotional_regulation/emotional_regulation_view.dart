import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_back_arrow.dart';
import 'emotional_regulation_controller.dart';

TextStyle _manrope(double size, FontWeight weight, double alpha,
        {Color color = AppColors.ink, double? height}) =>
    TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: weight,
      color: color.withValues(alpha: alpha),
      height: height,
    );

class EmotionalRegulationView extends GetView<EmotionalRegulationController> {
  const EmotionalRegulationView({super.key});

  static String _t(String s) => EmotionalRegulationController.titleCase(s);

  @override
  Widget build(BuildContext context) {
    final lessons = EmotionalRegulationController.lessons;
    return ResponsiveLayout(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: Get.back,
                        tooltip: 'Back',
                        icon: const AppBackArrow(),
                      ),
                      // Gap between arrow and title; the title scales down
                      // on narrow screens instead of touching the arrow.
                      const SizedBox(width: 12),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Emotional Regulation',
                            style: _manrope(24, FontWeight.w700, 1),
                          ),
                        ),
                      ),
                      // Mirrors the arrow's width so the title stays centred.
                      const SizedBox(width: 60),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const _WeekCard(),
                const SizedBox(height: 13),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      Text(
                        _t(EmotionalRegulationController.sectionTitle),
                        style: _manrope(16, FontWeight.w700, .8),
                      ),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Goal:',
                              style: _manrope(13, FontWeight.w700, .8,
                                  height: 20 / 13),
                            ),
                            TextSpan(
                              text: '\n${_t(EmotionalRegulationController.goal)}',
                              style: _manrope(13, FontWeight.w500, .6,
                                  height: 20 / 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.ink.withValues(alpha: .1),
                      ),
                      for (final lesson in lessons) ...[
                        const SizedBox(height: 16),
                        Text(
                          _t(lesson.title),
                          style: _manrope(16, FontWeight.w700, .8),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _t(lesson.body),
                          style: _manrope(13, FontWeight.w500, .6,
                              height: 20 / 13),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Week card (Figma 390 x 124): title + dates on top, ring and day dots below.
class _WeekCard extends StatelessWidget {
  const _WeekCard();

  static const _days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withNoTextScaling(
      child: Container(
        height: 124,
        padding: const EdgeInsets.fromLTRB(24, 12, 23, 0),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.ink.withValues(alpha: .2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    EmotionalRegulationController.weekLabel,
                    style: _manrope(15, FontWeight.w800, .8,
                        color: AppColors.coral),
                  ),
                  Text(
                    EmotionalRegulationController.dateRange,
                    style: _manrope(13, FontWeight.w400, .4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 66,
              child: Row(
                children: [
                  const SizedBox(width: 66, height: 66, child: _Ring()),
                  const SizedBox(width: 17),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) {
                        final size = ((c.maxWidth - 6 * 4) / 7)
                            .clamp(20.0, 30.0)
                            .toDouble();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i = 0; i < _days.length; i++)
                              Container(
                                width: size,
                                height: size,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: i <
                                          EmotionalRegulationController
                                              .completedDays
                                      ? const Color(0xFF9AE66E)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: i <
                                          EmotionalRegulationController
                                              .completedDays
                                      ? null
                                      : Border.all(color: AppColors.divider),
                                ),
                                child: Text(
                                  _days[i],
                                  maxLines: 1,
                                  style: _manrope(
                                    (13 * size / 30).clamp(11.0, 13.0),
                                    FontWeight.w400,
                                    .8,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
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

class _Ring extends StatelessWidget {
  const _Ring();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RingPainter(EmotionalRegulationController.progress),
      child: Center(
        child: Text('40%', style: _manrope(13, FontWeight.w800, .7)),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter(this.progress);
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 7.0;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    canvas.drawArc(
      rect,
      0,
      6.283185307179586,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = Colors.white,
    );
    canvas.drawArc(
      rect,
      -1.5707963267948966,
      6.283185307179586 * progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = const Color(0xFFFF8B8F),
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
