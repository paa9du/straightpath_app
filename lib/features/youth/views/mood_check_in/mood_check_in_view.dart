import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/screen_header.dart';
import 'mood_check_in_controller.dart';

class MoodCheckInView extends GetView<MoodCheckInController> {
  const MoodCheckInView({super.key});

  static const moods = [
    (AppAssets.moodVeryGood, 'Very Good', '9-10', Color(0xFF5ED681)),
    (AppAssets.moodGood, 'Good', '7-8', Color(0xFF9BE069)),
    (AppAssets.moodNeutral, 'Neutral', '5-6', Color(0xFFDCD764)),
    (AppAssets.moodSad, 'Sad', '3-4', Color(0xFFDA9961)),
    (AppAssets.moodVeryBad, 'Very Bad', '1-2', Color(0xFFE6737A)),
  ];

  static const _ink = Color(0xFF101720);
  static const _rowHeight = 63.0;
  static const _thumb = 42.0;

  static TextStyle _style(double size, FontWeight w, Color c) => TextStyle(
        fontFamily: 'Manrope',
        fontSize: size,
        fontWeight: w,
        color: c,
        height: 1.0,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
            child: Column(
              children: [
                ScreenHeader(title: 'Mood Check-In', onBack: controller.back),
                const SizedBox(height: 18),
                Text(
                  'How Would You Describe\nYour Mood?',
                  textAlign: TextAlign.center,
                  style: _style(24, FontWeight.w800, _ink.withValues(alpha: .8)).copyWith(height: 1.35),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final h = c.maxHeight;
                      final gap = (h - _rowHeight) / (moods.length - 1);
                      return Obx(() {
                        final selected = controller.selectedIndex.value;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width: 24,
                                height: h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: (selected * gap + _rowHeight / 2).round(),
                                        child: const DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xFFFFFDEE),
                                                Color(0xFFFFFAE3),
                                              ],
                                            ),
                                          ),
                                          child: SizedBox.expand(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: (h - selected * gap - _rowHeight / 2).round(),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                moods[selected].$4,
                                                const Color(0xFFE6737A),
                                              ],
                                            ),
                                          ),
                                          child: const SizedBox.expand(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            for (var i = 0; i < moods.length; i++)
                              Positioned(
                                left: 0,
                                right: 0,
                                top: i * gap,
                                height: _rowHeight,
                                child: InkWell(
                                  onTap: () => controller.select(i),
                                  borderRadius: BorderRadius.circular(14),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                moods[i].$2,
                                                style: _style(16, FontWeight.w600, _ink.withValues(alpha: .8)),
                                              ),
                                              const SizedBox(height: 11),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.favorite_border_rounded,
                                                    size: 16,
                                                    color: Color(0xFF2D264B),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    moods[i].$3,
                                                    style: _style(16, FontWeight.w600, moods[i].$4),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: _rowHeight,
                                          height: _rowHeight,
                                          child: Image.asset(moods[i].$1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 180),
                              top: selected * gap + (_rowHeight - _thumb) / 2,
                              left: (c.maxWidth - _thumb) / 2,
                              child: IgnorePointer(
                                child: Container(
                                  width: _thumb,
                                  height: _thumb,
                                  decoration: BoxDecoration(
                                    color: moods[selected].$4,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: FilledButton(
                      onPressed: controller.continueFlow,
                      style: FilledButton.styleFrom(
                        backgroundColor: _ink.withValues(alpha: .8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Mood Check-In',
                          style: _style(18, FontWeight.w500, Colors.white),
                        ),
                      ),
                    ),
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
