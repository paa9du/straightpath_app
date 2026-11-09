import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_back_arrow.dart';
import 'skill_detail_controller.dart';

TextStyle _manrope(double size, FontWeight weight, Color color,
        {double? height}) =>
    TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );

class SkillDetailView extends GetView<SkillDetailController> {
  const SkillDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            children: [
              SizedBox(
                height: 52,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: Get.back,
                        tooltip: 'Back',
                        padding: EdgeInsets.zero,
                        icon: const AppBackArrow(),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Sphere(theme: controller.theme),
                        const SizedBox(width: 10),
                        Text(
                          controller.title,
                          style: _manrope(24, FontWeight.w700, AppColors.ink),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              for (var i = 0; i < SkillDetailController.exerciseCount; i++) ...[
                if (i > 0) const SizedBox(height: 13),
                const _ExerciseCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Sphere extends StatelessWidget {
  const _Sphere({required this.theme});
  final SkillTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-.3, -.35),
          radius: .9,
          colors: [theme.light, theme.base, theme.dark],
          stops: const [0, .55, 1],
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard();

  @override
  Widget build(BuildContext context) {
    final text = AppColors.ink.withValues(alpha: .8);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 23, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ink.withValues(alpha: .2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            SkillDetailController.exerciseTitle,
            style: _manrope(16, FontWeight.w700, text),
          ),
          const SizedBox(height: 14),
          Text('STEPS', style: _manrope(13, FontWeight.w400, text)),
          const SizedBox(height: 14),
          for (var i = 0; i < SkillDetailController.steps.length; i++)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 19.5,
                  child: Text('${i + 1}.',
                      style: _manrope(13, FontWeight.w400, text, height: 20 / 13)),
                ),
                Expanded(
                  child: Text(
                    SkillDetailController.steps[i],
                    style: _manrope(13, FontWeight.w400, text, height: 20 / 13),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 19),
          const _AudioCard(),
        ],
      ),
    );
  }
}

class _AudioCard extends StatelessWidget {
  const _AudioCard();

  static const _green = Color(0xFF4CBF88);

  @override
  Widget build(BuildContext context) {
    final text = AppColors.ink.withValues(alpha: .8);
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ink.withValues(alpha: .1)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 7,
            left: 0,
            right: 0,
            child: Center(
              child: Text('STEPS AUDIO',
                  style: _manrope(13, FontWeight.w400, text)),
            ),
          ),
          Positioned(
            top: 33,
            left: 24,
            right: 24,
            height: 28,
            child: CustomPaint(painter: _WavePainter()),
          ),
          Positioned(
            top: 59,
            left: 24,
            child: Text('2:36', style: _manrope(13, FontWeight.w400, text)),
          ),
          Positioned(
            top: 59,
            right: 24,
            child: Text('4:50', style: _manrope(13, FontWeight.w400, text)),
          ),
          Positioned(
            top: 74,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Waveform: coloured (played) bars on the left, grey bars on the right.
/// Designed on a 300 wide canvas and scaled to the available width.
class _WavePainter extends CustomPainter {
  static const _played = <double>[
    14, 18, 22, 12, 20, 16, 24, 10, 18, 22, 14, 26, 18, 12, 20, 24, 14, 18, 22,
    16, 12, 20, 16,
  ];
  static const _rest = <double>[
    9.94, 13.554, 17.169, 9.94, 4.518, 18.976, 13.554, 20.783, 17.169, 9.94,
    13.554, 9.94, 17.169, 13.554, 15.361, 9.94, 13.554, 4.518, 9.94, 18.976,
    13.554, 20.783, 17.169, 9.94, 13.554, 9.94, 15.361, 13.554, 15.361, 9.94,
    13.554, 4.518, 18.976,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 300;
    const step = 5.42;
    final midY = size.height / 2;
    final grey = Paint()..color = const Color(0xFF101720).withValues(alpha: .1);
    final total = _played.length + _rest.length;
    for (var i = 0; i < total; i++) {
      final isPlayed = i < _played.length;
      final h = isPlayed ? _played[i] : _rest[i - _played.length];
      final paint = isPlayed
          ? (Paint()
            ..color = Color.lerp(const Color(0xFFF5B84A),
                const Color(0xFFFF6464), i / (_played.length - 1))!)
          : grey;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(i * step * s, midY - h / 2, 1.807 * s.clamp(.8, 2), h),
        const Radius.circular(8),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
