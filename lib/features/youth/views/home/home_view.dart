import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/navigation/app_bottom_navigation.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import 'home_controller.dart';
import 'widgets/daily_progress_tracker.dart';
import 'widgets/mood_selector.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _navItems = [
    AppNavItem(
      label: 'Today',
      iconAsset: AppAssets.homeOutline,
      activeIconAsset: AppAssets.home,
    ),
    AppNavItem(
      label: 'Weekly',
      iconAsset: AppAssets.calendar,
      activeIconAsset: AppAssets.calendarFilled,
    ),
    AppNavItem(label: 'Skills', iconAsset: AppAssets.skills),
    AppNavItem(
      label: 'Message',
      iconAsset: AppAssets.message,
      activeIconAsset: AppAssets.messageFilled,
    ),
    AppNavItem(
      label: 'Profile',
      iconAsset: AppAssets.profile,
      activeIconAsset: AppAssets.profileFilled,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _UserHeader(),
                          const SizedBox(height: 20),
                          DailyTabs(currentIndex: 0, onTap: controller.onDailyTab),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Course Progress',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.ink.withValues(alpha: .8),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: controller.openWeeklyProgress,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      'See More',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.ink.withValues(alpha: .3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _CourseProgressCard(onContinue: controller.openLessons),
                            const SizedBox(height: 24),
                            Text(
                              'Mood Check-In',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 9),
                            Obx(
                              () => MoodSelector(
                                moods: controller.moods,
                                selectedIndex: controller.selectedMoodIndex.value,
                                onSelected: controller.selectMood,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Daily Progress Tracker',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 9),
                            const DailyProgressTracker(completedSteps: 1),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                      child: AppPrimaryButton(
                        label: 'Start Today',
                        gradient: true,
                        onPressed: controller.startToday,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => AppBottomNavigation(
                  items: _navItems,
                  currentIndex: controller.currentNavigationIndex.value,
                  onTap: controller.selectNavigationItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma: 42px avatar, 10 gap, name (16 bold) over program (14) with 1px
    // between; the date (14 medium, 50%) is top-aligned with the name and
    // right-aligned to the 20px margin.
    return MediaQuery.withNoTextScaling(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              AppAssets.youthAvatar,
              width: 42,
              height: 42,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Michael Thompson',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 1),
                // Shrinks slightly on narrow screens so the whole line shows.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Current Program',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        const TextSpan(text: ': '),
                        TextSpan(
                          text: 'Behavioral Health',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink.withValues(alpha: .8),
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink.withValues(alpha: .5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Wed, 21 Jan',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.ink.withValues(alpha: .5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Course progress card, built from the Figma frame (390 x 160).
///
/// Figma spacing: 23 left margin, ring 66, 17 gap, seven 30px day circles
/// (8 apart), 24-26 right margin. Row 2 starts at y = 85, "Continue" at 123.
/// The card is a fixed-height design, so it ignores the system font scale.
class _CourseProgressCard extends StatelessWidget {
  const _CourseProgressCard({required this.onContinue});

  final VoidCallback onContinue;

  static const _days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  static const _doneDays = 3;

  static TextStyle _text(
    double size,
    FontWeight weight,
    double alpha, {
    Color color = AppColors.ink,
  }) {
    return TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: weight,
      color: color.withValues(alpha: alpha),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withNoTextScaling(
      child: Container(
        height: 160,
        padding: const EdgeInsets.fromLTRB(22, 9, 22, 0),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.ink.withValues(alpha: .2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ring + day circles (y = 9 .. 75).
            SizedBox(
              height: 66,
              child: Row(
                children: [
                  const SizedBox(width: 66, height: 66, child: _ProgressRing()),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // 30px circles when there is room (390 wide card),
                          // otherwise shrink them, keeping at least 4px gaps.
                          final size = ((constraints.maxWidth - 6 * 4) / 7)
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
                                    color: i < _doneDays
                                        ? const Color(0xFF9AE66E)
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: i < _doneDays
                                        ? null
                                        : Border.all(color: AppColors.divider),
                                  ),
                                  child: Text(
                                    _days[i],
                                    maxLines: 1,
                                    style: _text(
                                      (13 * size / 30).clamp(11.0, 13.0).toDouble(),
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
                  ),
                ],
              ),
            ),
            // Week title + dates (y = 85). On cards narrower than the 390px
            // design the whole row scales down together instead of squeezing
            // only the title.
            const SizedBox(height: 10),
            SizedBox(
              height: 20,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Figma: 56px box, right-aligned text. It must
                              // never wrap, so the box only sets a minimum.
                              ConstrainedBox(
                                constraints: const BoxConstraints(minWidth: 56),
                                child: Text(
                                  'Week 1:',
                                  maxLines: 1,
                                  softWrap: false,
                                  textAlign: TextAlign.right,
                                  style: _text(
                                    15,
                                    FontWeight.w800,
                                    .8,
                                    color: const Color(0xFFFF6464),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Emotional Regulation',
                                maxLines: 1,
                                softWrap: false,
                                style: _text(15, FontWeight.w700, .8),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                          Text(
                            '23 Jan  - 29 Jan',
                            maxLines: 1,
                            softWrap: false,
                            style: _text(13, FontWeight.w400, .4),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // "Continue" (y = 123).
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onContinue,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 2, 4),
                  child: Text(
                    'Continue →',
                    style: _text(13, FontWeight.w400, .8),
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

/// 66px progress ring: white track, coral arc for 40 %, label in the middle.
class _ProgressRing extends StatelessWidget {
  const _ProgressRing();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RingPainter(progress: .4),
      child: Center(
        child: Text(
          '40%',
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.ink.withValues(alpha: .7),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress});

  final double progress;

  static const _stroke = 7.0;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_stroke / 2);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke
      ..color = Colors.white;
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFFF8B8F);
    canvas.drawArc(rect, 0, 6.283185307179586, false, track);
    canvas.drawArc(
      rect,
      -1.5707963267948966,
      6.283185307179586 * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
