import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'reflection_controller.dart';

class ReflectionView extends GetView<ReflectionController> {
  const ReflectionView({super.key});

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
                      'Reflection',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DailyTabs(currentIndex: 4, onTap: controller.onDailyTab),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'What Stood Out To You Today?',
                      textAlign: TextAlign.center,
                      style: _manrope(18, FontWeight.w600, AppColors.ink.withValues(alpha: .8)),
                    ),
                    const SizedBox(height: 16),
                    Obx(() => _ModeToggle(
                          selected: controller.mode.value,
                          onChanged: controller.setMode,
                        )),
                    const SizedBox(height: 16),
                    Obx(
                      () => controller.mode.value == 0
                          ? Container(
                              key: const ValueKey('text-note'),
                              constraints: const BoxConstraints(minHeight: 395),
                              decoration: _noteDecoration,
                              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                              child: TextField(
                                controller: controller.noteController,
                                minLines: 10,
                                maxLines: 14,
                                style: _manrope(15, FontWeight.w500, AppColors.ink.withValues(alpha: .8), height: 1.4),
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  filled: false,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'You Can Write As Much Or As Little As You Want.',
                                  hintStyle: _manrope(15, FontWeight.w500, AppColors.ink.withValues(alpha: .4), height: 1.4),
                                ),
                              ),
                            )
                          : SizedBox(
                              key: const ValueKey('voice-note'),
                              height: 395,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: controller.toggleRecording,
                                    behavior: HitTestBehavior.opaque,
                                    child: SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          _ring(300, const Color(0xFFFFFEFA), .04),
                                          _ring(220, const Color(0xFFFFFDF1), .05),
                                          _ring(160, const Color(0xFFFFFCE8), .05),
                                          controller.isRecording.value
                                              ? const Icon(
                                                  Icons.stop_rounded,
                                                  color: Color(0xFF2D264B),
                                                  size: 80,
                                                )
                                              : const SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: CustomPaint(painter: _MicPainter()),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: Text(
                                      controller.isRecording.value
                                          ? 'Tap To Stop'
                                          : 'Tap To Record',
                                      style: _manrope(18, FontWeight.w600, AppColors.ink.withValues(alpha: .8)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
              child: SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: controller.submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink.withValues(alpha: .8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Submit Reflection', style: _manrope(15, FontWeight.w500, Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _manrope(double size, FontWeight w, Color c, {double height = 1.0}) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: w,
      color: c,
      height: height,
    );

const _accentGradient = LinearGradient(
  colors: [Color(0xCCF5B84A), Color(0xCCFF6464)],
);

final _noteDecoration = BoxDecoration(
  color: const Color(0xFFFFFDEE),
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: AppColors.ink.withValues(alpha: .1)),
);

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget item(int i, String label) {
      final active = selected == i;
      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(i),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: active ? _accentGradient : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: active
                    ? _manrope(16, FontWeight.w800, Colors.white)
                    : _manrope(16, FontWeight.w600, AppColors.ink.withValues(alpha: .4)),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: [item(0, 'Text Note'), item(1, 'Voice Note')]),
    );
  }
}

Widget _ring(double size, Color color, double shadowAlpha) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: shadowAlpha),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

class _MicPainter extends CustomPainter {
  const _MicPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / 100;
    final paint = Paint()
      ..color = const Color(0xFF2D264B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6 * k
      ..strokeCap = StrokeCap.round;
    // capsule
    canvas.drawRRect(
      RRect.fromLTRBR(33 * k, 8 * k, 67 * k, 58 * k, Radius.circular(17 * k)),
      paint,
    );
    // cradle arc
    canvas.drawArc(
      Rect.fromLTRB(16.5 * k, 22 * k, 83.5 * k, 76 * k),
      0,
      3.14159265,
      false,
      paint,
    );
    // stem + base
    canvas.drawLine(Offset(50 * k, 76 * k), Offset(50 * k, 92 * k), paint);
    canvas.drawLine(Offset(36 * k, 92 * k), Offset(64 * k, 92 * k), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
