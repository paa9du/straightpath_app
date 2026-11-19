import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/title_case.dart';
import '../../models/person_summary.dart';
import '../common/app_press_effect.dart';

/// Figma coral -> orange gradient used by the progress fill and active chip.
const overviewGradient = LinearGradient(
  colors: [Color(0xFFE8777E), Color(0xFFEAB078)],
);

/// 14px "Right 2" chevron (ink @ 30%) exactly as drawn in Figma.
class OverviewChevron extends StatelessWidget {
  const OverviewChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: Stack(
        children: [
          Positioned(
            left: 5.396,
            top: 3.646,
            child: SvgPicture.asset(
              AppAssets.chevronRight,
              width: 3.20833,
              height: 6.70833,
            ),
          ),
        ],
      ),
    );
  }
}

class PersonSummaryCard extends StatelessWidget {
  const PersonSummaryCard({
    required this.person,
    this.showActions = true,
    this.onTap,
    this.onAddNote,
    this.onSendMessage,
    super.key,
  });

  final PersonSummary person;
  final bool showActions;
  final VoidCallback? onTap;
  final VoidCallback? onAddNote;
  final VoidCallback? onSendMessage;

  // Figma 784:1273: 180 without the progress line, 198 / 206 with it.
  double get _cardHeight {
    if (person.weeklyProgress == null) return 180;
    return person.tracker == TrackerKind.program ? 198 : 206;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPressEffect(
          child: Material(
            color: AppColors.cream,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.ink.withValues(alpha: .2)),
            ),
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                height: _cardHeight,
                width: double.infinity,
                child: _CardBody(person: person),
              ),
            ),
          ),
        ),
        if (showActions) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Add Note',
                  onTap: onAddNote,
                  icon: const _GlyphIcon(
                    asset: AppAssets.addNote,
                    left: 2.25,
                    top: 1.25,
                    width: 19.5,
                    height: 21.5,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  label: 'Send Message',
                  onTap: onSendMessage,
                  icon: const _GlyphIcon(
                    asset: AppAssets.sendMessage,
                    left: 1.25,
                    top: 1.25,
                    width: 21.4981,
                    height: 21.5258,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({required this.person});

  final PersonSummary person;

  @override
  Widget build(BuildContext context) {
    final dim = AppColors.ink.withValues(alpha: .8);
    final faint = AppColors.ink.withValues(alpha: .3);
    return Stack(
      children: [
        Positioned(
          left: 25,
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
          left: 83,
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
          left: 83,
          right: 20,
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
          right: 27,
          top: 20,
          child: Row(
            children: [
              Text(
                'Explore',
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  fontWeight: FontWeight.w600,
                  color: faint,
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
        Positioned(
          left: 25,
          top: 77,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Status:',
                  style: TextStyle(fontWeight: FontWeight.w700, color: dim),
                ),
                TextSpan(
                  text: ' ${person.statusDate}',
                  style: TextStyle(fontWeight: FontWeight.w500, color: faint),
                ),
              ],
            ),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Positioned(
          left: 28,
          right: 27,
          top: 106,
          height: 56,
          child: _Tracker(
            kind: person.tracker,
            completed: person.completedSteps,
          ),
        ),
        if (person.weeklyProgress case final progress?)
          Positioned(
            left: 29,
            top: person.tracker == TrackerKind.program ? 166 : 169,
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Weekly Course Progress '),
                  TextSpan(
                    text: '$progress%',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0x94000000),
              ),
            ),
          ),
      ],
    );
  }
}

/// Labels (y 106), 20px step circles (y 138) and the 8px track (y 144) from
/// Figma. Daily circle centres sit at 0 / 33.65 / 62.22 / 100 % of the track;
/// program circles follow Figma 784:1309 (x 28 / 104 / 183 / 262 / 341).
class _Tracker extends StatelessWidget {
  const _Tracker({required this.kind, required this.completed});

  final TrackerKind kind;
  final int completed;

  static const _dailyLabels = ['Check-In', 'Focus', 'Activity', 'Reflection'];
  static const _dailyFractions = [0.0, 106 / 315, 196 / 315, 1.0];

  static const _programLabels = [
    'Orientation &\nTrust Building',
    'Group\nAgreements',
    'Focus',
    'My Goals',
    'Trust Meter',
  ];
  static const _programFractions = [
    0.0,
    76 / 315,
    155 / 315,
    234 / 315,
    313 / 315,
  ];

  /// Per program label: x offset from its circle centre, top, and whether
  /// that x is the label's right edge (otherwise its left edge).
  static const _programAnchors = [
    (-14.0, -2.0, false),
    (-8.0, -2.0, false),
    (15.0, 4.0, true),
    (21.0, 4.0, true),
    (23.0, 4.0, true),
  ];

  @override
  Widget build(BuildContext context) {
    final program = kind == TrackerKind.program;
    final labels = program ? _programLabels : _dailyLabels;
    final fractions = program ? _programFractions : _dailyFractions;
    final count = labels.length;
    final done = completed.clamp(0, count);
    final ink80 = AppColors.ink.withValues(alpha: .8);
    final dailyStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: ink80,
    );
    TextStyle programStyle(int i) => TextStyle(
      fontSize: 8,
      height: 11 / 8,
      fontWeight: FontWeight.w600,
      color: i < done ? const Color(0xFFE8857C) : ink80,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double centre(int i) => 10 + fractions[i] * (width - 20);
        // Figma: the fill runs up to the next (current) step's circle.
        final fillEnd = centre(done.clamp(0, count - 1));
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (program)
              for (var i = 0; i < count; i++)
                Positioned(
                  left: centre(i) + _programAnchors[i].$1,
                  top: _programAnchors[i].$2,
                  child: FractionalTranslation(
                    translation: Offset(_programAnchors[i].$3 ? -1 : 0, 0),
                    child: Text(
                      labels[i],
                      textAlign: _programAnchors[i].$3
                          ? TextAlign.right
                          : TextAlign.left,
                      style: programStyle(i),
                    ),
                  ),
                )
            else ...[
              Positioned(
                left: 0,
                top: 0,
                child: Text(labels[0], style: dailyStyle),
              ),
              for (final i in [1, 2])
                Positioned(
                  left: centre(i),
                  top: 0,
                  child: FractionalTranslation(
                    translation: const Offset(-.5, 0),
                    child: Text(labels[i], style: dailyStyle),
                  ),
                ),
              Positioned(
                right: 0,
                top: 0,
                child: Text(labels[3], style: dailyStyle),
              ),
            ],
            // Track (y 144 -> 38 from the labels' top).
            Positioned(
              left: 0,
              right: 0,
              top: 38,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
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
                left: 0,
                width: fillEnd,
                top: 38,
                height: 8,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: overviewGradient,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            for (var i = 0; i < count; i++)
              Positioned(
                left: centre(i) - 12,
                top: 30,
                child: _Step(done: i < done, next: i == done && i != count - 1),
              ),
          ],
        );
      },
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.done, required this.next});

  final bool done;
  final bool next;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: next
                    ? const Color(0xFFE8777E)
                    : AppColors.ink.withValues(alpha: .08),
              ),
            ),
          ),
          if (done)
            SvgPicture.asset(AppAssets.checkCircle, width: 24, height: 24),
        ],
      ),
    );
  }
}

class _GlyphIcon extends StatelessWidget {
  const _GlyphIcon({
    required this.asset,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final String asset;
  final double left;
  final double top;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            left: left,
            top: top,
            child: SvgPicture.asset(asset, width: width, height: height),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressEffect(
      child: Material(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 48,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(width: 5),
                    Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 13,
                        height: 24 / 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink.withValues(alpha: .8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
