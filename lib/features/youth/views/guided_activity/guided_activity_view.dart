import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'guided_activity_controller.dart';

class GuidedActivityView extends GetView<GuidedActivityController> {
  const GuidedActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 0,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
          children: [
            Center(
              child: Text(
                'Guided Activity',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            DailyTabs(currentIndex: 3, onTap: controller.onDailyTab),
            const SizedBox(height: 26),
            Center(
              child: Text(
                'Take This At Your Own Pace.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 24),
            const _TimerRing(),
            const SizedBox(height: 24),
            // Controls: three 60px buttons, 16px apart (Figma 264:336-338).
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ControlButton(
                  glyph: _Glyph.previous,
                  tooltip: 'Previous step',
                  onPressed: controller.previousStep,
                ),
                const SizedBox(width: 16),
                Obx(
                  () => _ControlButton(
                    glyph: controller.isPlaying.value
                        ? _Glyph.pause
                        : _Glyph.play,
                    tooltip: controller.isPlaying.value ? 'Pause' : 'Play',
                    filled: true,
                    onPressed: controller.togglePlayback,
                  ),
                ),
                const SizedBox(width: 16),
                _ControlButton(
                  glyph: _Glyph.next,
                  tooltip: 'Next step',
                  onPressed: controller.nextStep,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Instruction card lists every step (Figma 259:2035).
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 19, 14, 19),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.ink.withValues(alpha: .1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final step in _steps)
                    Text(
                      step,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        height: 24 / 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.ink.withValues(alpha: .8),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.finish,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: const BorderSide(color: AppColors.ink),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Skip',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: controller.finish,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: AppColors.ink.withValues(alpha: .8),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Mark As Complete',
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const _steps = [
    '1.  Sit Comfortably With Your Feet On The Floor.',
    '2. Take A Slow Breath In Through Your Nose.',
    '3. Gently Release The Breath Through Your Mouth.',
    '4. Notice How Your Body Feels.',
  ];
}

/// 258px timer ring (Figma 264:341): 26px stroke, yellow arc from 3 o'clock
/// for 75 %, `#F6F6F6` track, "2:30 / Sec" centred.
class _TimerRing extends StatelessWidget {
  const _TimerRing();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth < 258 ? constraints.maxWidth : 258.0;
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: const _TimerRingPainter(progress: .75),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '2:30',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink.withValues(alpha: .8),
                      ),
                    ),
                    Text(
                      'Sec',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink.withValues(alpha: .4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  const _TimerRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 26 / 258;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = const Color(0xFFF6F6F6);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = const Color(0xFFF5B84A);
    const full = 6.283185307179586;
    canvas.drawArc(rect, 0, full, false, track);
    // Starts at 3 o'clock and runs clockwise, leaving the top-right gap.
    canvas.drawArc(rect, 0, full * progress, false, arc);
  }

  @override
  bool shouldRepaint(_TimerRingPainter old) => old.progress != progress;
}

enum _Glyph { previous, next, pause, play }

/// 60px rounded control button (Figma 264:317-319): filled ink @80 % or a
/// `#F6F6F6` outline, radius 16, 24px outline icon.
class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.glyph,
    required this.tooltip,
    required this.onPressed,
    this.filled = false,
  });

  final _Glyph glyph;
  final String tooltip;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: filled ? AppColors.ink.withValues(alpha: .8) : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: filled
              ? BorderSide.none
              : const BorderSide(color: Color(0xFFF6F6F6)),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 60,
            height: 60,
            child: Center(
              child: CustomPaint(
                size: const Size(24, 24),
                painter: _GlyphPainter(
                  glyph: glyph,
                  color: filled ? Colors.white : const Color(0xFF2D264B),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Thin outline media icons, drawn on a 24 x 24 grid like the Figma icons.
class _GlyphPainter extends CustomPainter {
  const _GlyphPainter({required this.glyph, required this.color});

  final _Glyph glyph;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color;
    switch (glyph) {
      case _Glyph.previous:
        canvas.drawLine(const Offset(5.25, 6.25), const Offset(5.25, 17.75), paint);
        canvas.drawPath(
          Path()
            ..moveTo(18, 6.8)
            ..lineTo(9.2, 12)
            ..lineTo(18, 17.2)
            ..close(),
          paint,
        );
      case _Glyph.next:
        canvas.drawLine(const Offset(18.75, 6.25), const Offset(18.75, 17.75), paint);
        canvas.drawPath(
          Path()
            ..moveTo(6, 6.8)
            ..lineTo(14.8, 12)
            ..lineTo(6, 17.2)
            ..close(),
          paint,
        );
      case _Glyph.pause:
        // Figma icon box is inset 34.4 % / 9.4 %, stroke included.
        canvas.drawLine(const Offset(9, 3), const Offset(9, 21), paint);
        canvas.drawLine(const Offset(15, 3), const Offset(15, 21), paint);
      case _Glyph.play:
        canvas.drawPath(
          Path()
            ..moveTo(9, 6.5)
            ..lineTo(18, 12)
            ..lineTo(9, 17.5)
            ..close(),
          paint,
        );
    }
  }

  @override
  bool shouldRepaint(_GlyphPainter old) =>
      old.glyph != glyph || old.color != color;
}
