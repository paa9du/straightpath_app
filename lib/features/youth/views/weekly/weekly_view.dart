import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import '../../../../shared/widgets/common/app_press_effect.dart';
import '../../../../core/utils/title_case.dart';
import '../../../../data/mock/mock_weeks.dart';
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
        body: Obx(() => ListView(
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
        )),
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({required this.week, required this.onTap});

  final WeekProgress week;
  final VoidCallback onTap;

  static const _ink = Color(0xFF101720);
  static const _green = Color(0xFFA5E970);
  static const _coral = Color(0xFFFF6464);

  static TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
        fontFamily: 'Manrope',
        fontSize: size,
        fontWeight: w,
        color: c,
      );

  @override
  Widget build(BuildContext context) {
    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    final weekDone = week.completedDays >= programDays;
    return AppPressEffect(
      child: Material(
        elevation: 0,
        color: const Color(0xFFFFFDEE),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _ink.withValues(alpha: .2)),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 17, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Figma row: 66 ring, 17 gap, 7 x 30 circles with 8 gaps.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 66,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 66,
                          height: 66,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(66, 66),
                                painter: _WeekRingPainter(week.progress),
                              ),
                              Text(
                                '${(week.progress * 100).round()}%',
                                style: _t(13, FontWeight.w800, _ink.withValues(alpha: .7)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 17),
                        for (var i = 0; i < days.length; i++) ...[
                          if (i > 0) const SizedBox(width: 8),
                          // Figma 151: a finished week fills all 7 days;
                          // otherwise done weekdays are green and the next
                          // one gets the coral ring.
                          _DayDot(
                            label: days[i],
                            done: weekDone || i < week.completedDays,
                            current: !weekDone &&
                                i == week.completedDays &&
                                week.completedDays > 0,
                            bold: weekDone && i == 0,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Week ${week.week}: ',
                        style: _t(15, FontWeight.w800, _coral.withValues(alpha: .8)),
                      ),
                      TextSpan(
                        text: week.title,
                        style: _t(15, FontWeight.w700, _ink.withValues(alpha: .8)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  titleCase(week.description),
                  style: _t(13, FontWeight.w400, _ink.withValues(alpha: .8)),
                ),
                const SizedBox(height: 11),
                Text(
                  week.dateRange,
                  style: _t(13, FontWeight.w400, _ink.withValues(alpha: .4)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({
    required this.label,
    required this.done,
    required this.current,
    required this.bold,
  });

  final String label;
  final bool done;
  final bool current;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final Color fill = done ? _WeekCard._green : Colors.white;
    final Color text = done
        ? _WeekCard._ink.withValues(alpha: .8)
        : current
            ? _WeekCard._ink.withValues(alpha: .8)
            : _WeekCard._ink.withValues(alpha: .3);
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: current
            ? Border.all(color: _WeekCard._coral.withValues(alpha: .8))
            : null,
      ),
      child: Text(
        label,
        style: _WeekCard._t(13, bold ? FontWeight.w800 : FontWeight.w400, text),
      ),
    );
  }
}

class _WeekRingPainter extends CustomPainter {
  const _WeekRingPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 7.0;
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(stroke / 2);
    canvas.drawArc(
      arcRect,
      0,
      6.2831853,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = Colors.white,
    );
    if (progress <= 0) return;
    canvas.drawArc(
      arcRect,
      -1.5707963,
      6.2831853 * progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..shader = const LinearGradient(
          colors: [Color(0xFFF5B84A), Color(0xFFFF6464)],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_WeekRingPainter old) => old.progress != progress;
}
