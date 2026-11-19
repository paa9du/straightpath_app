import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import 'weekly_day_widgets.dart';

/// "Monday Worksheet Completed!" popup (Figma 873:2941) over the blurred
/// worksheet (Figma 873:2953).
class WorksheetCompletedDialog extends StatelessWidget {
  const WorksheetCompletedDialog({
    required this.dayName,
    required this.onContinue,
    super.key,
  });

  final String dayName;
  final VoidCallback onContinue;

  static Future<void> show({
    required String dayName,
    required VoidCallback onContinue,
  }) {
    return Get.generalDialog<void>(
      barrierDismissible: true,
      barrierLabel: 'Worksheet completed',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (context, animation, secondary) =>
          WorksheetCompletedDialog(dayName: dayName, onContinue: onContinue),
      transitionBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );
        return Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: curved,
                builder: (context, _) => BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5 * curved.value,
                    sigmaY: 5 * curved.value,
                  ),
                  child: ColoredBox(
                    color: AppColors.ink.withValues(alpha: .3 * curved.value),
                  ),
                ),
              ),
            ),
            FadeTransition(opacity: curved, child: child),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Laid out on Figma's 390 x 310 card and scaled down as one piece on
    // narrower phones.
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: MediaQuery.withNoTextScaling(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: 390,
                height: 310,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 46, 18, 24),
                        child: Column(
                          children: [
                            Container(
                              width: 70.56,
                              height: 70.56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF22B087),
                                  width: 6,
                                ),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.worksheetDoneCheck,
                                width: 35.28,
                                height: 35.28,
                              ),
                            ),
                            const SizedBox(height: 21.4),
                            Text(
                              '$dayName Worksheet Completed!',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: weeklyText(
                                22.05,
                                weight: FontWeight.w700,
                                color: WeeklyColors.navy,
                                letterSpacing: -0.55,
                              ),
                            ),
                            const SizedBox(height: 7.4),
                            Text(
                              "You've completed all activities for $dayName",
                              textAlign: TextAlign.center,
                              style: weeklyText(
                                13.23,
                                color: const Color(0xFF334155),
                                height: 18.19 / 13.23,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              height: 62,
                              child: Material(
                                color: AppColors.ink.withValues(alpha: .8),
                                borderRadius: BorderRadius.circular(16),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: onContinue,
                                  child: Center(
                                    child: Text(
                                      'Continue',
                                      style: weeklyText(
                                        18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 7.97,
                      child: Semantics(
                        button: true,
                        label: 'Close',
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: Get.back,
                          child: SvgPicture.asset(
                            AppAssets.dialogClose,
                            width: 38.03,
                            height: 38.03,
                          ),
                        ),
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
