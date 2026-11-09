import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_interaction_feedback.dart';
import '../../../core/utils/title_case.dart';
import '../../models/person_summary.dart';
import '../cards/person_summary_card.dart';
import 'screen_header.dart';

/// Youth detail screen (Figma 516:1308). The card is laid out from the Figma
/// frame: 390 wide, 15px side padding, 360px inner boxes.
class YouthDetailContent extends StatelessWidget {
  const YouthDetailContent({
    required this.person,
    required this.onBack,
    required this.onOpenNotes,
    this.onOpenChat,
    super.key,
  });

  final PersonSummary person;
  final VoidCallback onBack;
  final VoidCallback onOpenNotes;
  final VoidCallback? onOpenChat;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      children: [
        ScreenHeader(title: person.name, onBack: onBack),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.ink.withValues(alpha: .2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(person: person, onExplore: onOpenNotes),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 19, 15, 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const _SectionTitle('Course Progress'),
                        const Spacer(),
                        InkWell(
                          onTap: () => AppInteractionFeedback.showSelection(
                            context,
                            'Course Progress',
                          ),
                          child: Text(
                            'See More',
                            style: TextStyle(
                              fontSize: 12.923,
                              fontWeight: FontWeight.w500,
                              color: AppColors.ink.withValues(alpha: .3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9.3),
                    const _CourseBox(),
                    const SizedBox(height: 22.15),
                    const _SectionTitle('Mood Check-In'),
                    const SizedBox(height: 9.3),
                    const _MoodBox(),
                    const SizedBox(height: 22.15),
                    const _SectionTitle('Daily Progress Tracker'),
                    const SizedBox(height: 9.3),
                    const _DailyTrackerBox(completed: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleCase(text),
      style: TextStyle(
        fontSize: 16.615,
        fontWeight: FontWeight.w600,
        color: AppColors.ink.withValues(alpha: .8),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.person, required this.onExplore});

  final PersonSummary person;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 93,
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 15,
            child: ClipOval(
              child: Image.asset(
                person.imagePath,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 73,
            top: 15,
            child: Text(
              titleCase(person.name),
              maxLines: 1,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
          ),
          Positioned(
            left: 73,
            right: 15,
            top: 39,
            child: Text(
              titleCase(person.program),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                height: 24 / 15,
                fontWeight: FontWeight.w500,
                color: AppColors.ink.withValues(alpha: .5),
              ),
            ),
          ),
          Positioned(
            right: 14,
            top: 19,
            child: InkWell(
              onTap: onExplore,
              child: Row(
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink.withValues(alpha: .3),
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: OverviewChevron(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 76,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Status:',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink.withValues(alpha: .8),
                    ),
                  ),
                  TextSpan(
                    text: ' ${person.statusDate}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink.withValues(alpha: .3),
                    ),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _boxDecoration(double borderAlpha) => BoxDecoration(
  color: AppColors.cream,
  borderRadius: BorderRadius.circular(14.77),
  border: Border.all(color: AppColors.ink.withValues(alpha: borderAlpha)),
);

class _CourseBox extends StatelessWidget {
  const _CourseBox();

  static const _days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 147.7,
      width: double.infinity,
      decoration: _boxDecoration(.2),
      child: LayoutBuilder(
        builder: (context, c) {
          final roomy = c.maxWidth >= 340;
          final side = roomy ? 21.2 : 14.0;
          final ring = roomy ? 60.9 : 54.0;
          final daysLeft = side + ring + (roomy ? 15.7 : 10.0);
          final daysWidth = c.maxWidth - daysLeft - (roomy ? 22.0 : 12.0);
          final dot = math.min(27.7, (daysWidth - 6 * 3) / 7);
          final ringTop = 8.3 + (60.9 - ring) / 2;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: side,
                top: ringTop,
                width: ring,
                height: ring,
                child: CustomPaint(
                  painter: const _RingPainter(.4),
                  child: Center(
                    child: Text(
                      '40%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink.withValues(alpha: .7),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: daysLeft,
                top: 8.3 + 30.45 - dot / 2,
                width: daysWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < _days.length; i++)
                      Container(
                        width: dot,
                        height: dot,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i < 3
                              ? const Color(0xFF9AE66E)
                              : Colors.white,
                          border: Border.all(
                            color: i < 3
                                ? const Color(0xFF8ED95F)
                                : AppColors.ink.withValues(alpha: .1),
                          ),
                        ),
                        child: Text(
                          _days[i],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.ink.withValues(alpha: .8),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                left: side,
                right: side,
                top: 78.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Text(
                              'Week 1:',
                              style: TextStyle(
                                fontSize: 13.846,
                                fontWeight: FontWeight.w800,
                                color: Color(0xCCFF6464),
                              ),
                            ),
                            const SizedBox(width: 2.5),
                            Text(
                              'Emotional Regulation',
                              style: TextStyle(
                                fontSize: 13.846,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink.withValues(alpha: .8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '23 Jan - 29 Jan',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.ink.withValues(alpha: .4),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: roomy ? 24 : 16,
                top: 113.5,
                child: Text(
                  'Continue →',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.ink.withValues(alpha: .8),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter(this.value);

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 7.4;
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(stroke / 2);
    canvas.drawArc(
      arcRect,
      0,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = Colors.white,
    );
    canvas.drawArc(
      arcRect,
      -math.pi / 2,
      math.pi * 2 * value,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = stroke
        ..color = const Color(0xFFFF8B8F),
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.value != value;
}

class _MoodBox extends StatelessWidget {
  const _MoodBox();

  static const _moods = [
    (AppAssets.moodVeryBad, 'Very Bad', 0.1153),
    (AppAssets.moodSad, 'Sad', 0.3028),
    (AppAssets.moodNeutral, 'Neutral', 0.4875),
    (AppAssets.moodGood, 'Good', 0.6717),
    (AppAssets.moodVeryGood, 'Very Good', 0.8708),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 147.7,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.77),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF5B84A).withValues(alpha: .5),
            const Color(0xFFFF6464).withValues(alpha: .5),
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (final mood in _moods)
                Positioned(
                  left: mood.$3 * c.maxWidth,
                  top: 11.08,
                  child: FractionalTranslation(
                    translation: const Offset(-.5, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 44.3,
                          height: 56.3,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 4.6,
                                top: 49.85,
                                child: Container(
                                  width: 34.15,
                                  height: 6.46,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withValues(alpha: .08),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: .1,
                                        ),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(mood.$1, width: 44.3, height: 44.3),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4.7),
                        Text(
                          mood.$2,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 11.077,
                            fontWeight: FontWeight.w600,
                            color: AppColors.ink.withValues(alpha: .8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                left: 7.38,
                right: 7.38,
                top: 96.9,
                height: 38.8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .7),
                    borderRadius: BorderRadius.circular(9.23),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Last Check-In:',
                          style: TextStyle(
                            fontSize: 14.769,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink.withValues(alpha: .8),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Good',
                          style: TextStyle(
                            fontSize: 14.769,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF70C144),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(AppAssets.moodGood, width: 18.46, height: 18.46),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DailyTrackerBox extends StatelessWidget {
  const _DailyTrackerBox({required this.completed});

  final int completed;

  static const _labels = ['Check-In', 'Focus', 'Activity', 'Reflection'];
  static const _fractions = [0.0, 106 / 315, 196 / 315, 1.0];
  static const _d = 18.46;

  @override
  Widget build(BuildContext context) {
    final done = completed.clamp(0, _labels.length);
    final labelStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.ink.withValues(alpha: .8),
    );
    return Container(
      height: 92.3,
      width: double.infinity,
      decoration: _boxDecoration(.1),
      child: LayoutBuilder(
        builder: (context, c) {
          const left = 24.0;
          const rightPad = 26.8;
          final trackW = c.maxWidth - left - rightPad;
          double centre(int i) => left + _d / 2 + _fractions[i] * (trackW - _d);
          final fillEnd = centre(done.clamp(0, _labels.length - 1));
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(left: 17.5, top: 17.5, child: Text(_labels[0], style: labelStyle)),
              for (final i in [1, 2])
                Positioned(
                  left: centre(i),
                  top: 17.5,
                  child: FractionalTranslation(
                    translation: const Offset(-.5, 0),
                    child: Text(_labels[i], style: labelStyle),
                  ),
                ),
              Positioned(
                right: rightPad - 7.4,
                top: 17.5,
                child: Text(_labels[3], style: labelStyle),
              ),
              Positioned(
                left: left,
                width: trackW,
                top: 52.6,
                height: 7.385,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.46),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.46),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: .08),
                            Colors.transparent,
                          ],
                          stops: const [0, .35],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (done > 0)
                Positioned(
                  left: left,
                  width: fillEnd - left,
                  top: 52.6,
                  height: 7.385,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: overviewGradient,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(18.46),
                      ),
                    ),
                  ),
                ),
              for (var i = 0; i < _labels.length; i++)
                Positioned(
                  left: centre(i) - 11.08,
                  top: 45.23,
                  child: SizedBox(
                    width: 22.15,
                    height: 22.15,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: _d,
                          height: _d,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: i == done && i != _labels.length - 1
                                  ? const Color(0xFFE8777E)
                                  : AppColors.ink.withValues(alpha: .08),
                            ),
                          ),
                        ),
                        if (i < done)
                          SvgPicture.asset(
                            AppAssets.checkCircle,
                            width: 22.15,
                            height: 22.15,
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
