import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';

/// Daily progress tracker card, laid out from the Figma frame (387 x 99).
/// All coordinates below are Figma pixels and are scaled to the card width.
class DailyProgressTracker extends StatelessWidget {
  const DailyProgressTracker({
    this.labels = const ['Check-In', 'Focus', 'Activity', 'Reflection'],
    this.completedSteps = 1,
    super.key,
  });

  final List<String> labels;

  /// Steps already done. The next step is drawn as the current one.
  final int completedSteps;

  static const _designWidth = 387.0;
  static const _designHeight = 99.0;
  // Horizontal centre of each step marker.
  static const _nodeCenters = [36.0, 142.0, 232.0, 351.0];
  static const _trackLeft = 26.0;
  static const _trackWidth = 335.0;
  static const _trackTop = 57.0;
  static const _trackHeight = 8.0;
  static const _trackCenterY = _trackTop + _trackHeight / 2;

  @override
  Widget build(BuildContext context) {
    final done = completedSteps.clamp(0, labels.length);
    return Container(
      height: _designHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ink.withValues(alpha: .1)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final k = constraints.maxWidth / _designWidth;
          final fillEnd = done >= labels.length
              ? _trackLeft + _trackWidth
              : _nodeCenters[done] + 9;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < labels.length; i++)
                _label(
                  labels[i],
                  centerX: _nodeCenters[i] * k,
                  maxWidth: constraints.maxWidth,
                ),
              // Track.
              Positioned(
                left: _trackLeft * k,
                top: _trackTop,
                width: _trackWidth * k,
                height: _trackHeight,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFEDEDED), Colors.white],
                    ),
                  ),
                ),
              ),
              // Filled part of the track.
              if (done > 0)
                Positioned(
                  left: _trackLeft * k,
                  top: _trackTop,
                  width: (fillEnd - _trackLeft) * k,
                  height: _trackHeight,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        colors: [Color(0xFFE8777E), Color(0xFFEAB078)],
                      ),
                    ),
                  ),
                ),
              for (var i = 0; i < labels.length; i++)
                _marker(
                  k: k,
                  index: i,
                  completed: i < done,
                  current: i == done,
                ),
            ],
          );
        },
      ),
    );
  }

  static const _labelMargin = 16.0;

  TextStyle get _labelStyle => TextStyle(
    fontFamily: 'Manrope',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.ink.withValues(alpha: .8),
  );

  /// Label centred above its step marker (as in Figma), but never closer than
  /// [_labelMargin] to the card edges, so the first/last labels shift inward.
  Widget _label(
    String text, {
    required double centerX,
    required double maxWidth,
  }) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: _labelStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    final width = painter.width;
    final left = (centerX - width / 2)
        .clamp(_labelMargin, maxWidth - _labelMargin - width)
        .toDouble();
    return Positioned(
      top: 19,
      left: left,
      child: Text(text, maxLines: 1, style: _labelStyle),
    );
  }

  Widget _marker({
    required double k,
    required int index,
    required bool completed,
    required bool current,
  }) {
    final size = completed ? 24.0 : 20.0;
    return Positioned(
      left: _nodeCenters[index] * k - size / 2,
      top: _trackCenterY - size / 2,
      width: size,
      height: size,
      child: completed
          ? SvgPicture.asset(AppAssets.checkCircle, width: size, height: size)
          : DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: current
                    ? Border.all(color: const Color(0xFFE8777E))
                    : null,
                boxShadow: current
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .1),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
            ),
    );
  }
}
