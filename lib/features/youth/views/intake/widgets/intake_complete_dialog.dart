import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';

const _ink = Color(0xFF101720);

TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: w,
      color: c,
    );

/// "You're All Set" dialog shown after the last intake step (Figma 375:1764).
/// Background: 5px blur + ink @ 30 % overlay.
class IntakeCompleteDialog extends StatelessWidget {
  const IntakeCompleteDialog({
    required this.onGetStarted,
    this.programType = 'Behavioral Health',
    super.key,
  });

  final VoidCallback onGetStarted;
  final String programType;

  static Future<void> show({required VoidCallback onGetStarted}) {
    return Get.generalDialog<void>(
      barrierDismissible: false,
      barrierLabel: 'Intake complete',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (context, animation, secondary) =>
          IntakeCompleteDialog(onGetStarted: onGetStarted),
      transitionBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
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
                    color: _ink.withValues(alpha: .3 * curved.value),
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
    final soft = _ink.withValues(alpha: .5);
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: MediaQuery.withNoTextScaling(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.fromLTRB(18, 23, 18, 21),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You’re All Set',
                      style: _t(18, FontWeight.w600, _ink.withValues(alpha: .8)),
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(AppAssets.tickCircle, width: 24, height: 24),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Based On Your Answers, Here’s How We’ll Support You:',
                      maxLines: 1,
                      style: _t(14, FontWeight.w500, soft),
                    ),
                  ),
                ),
                const SizedBox(height: 34),
                Text(
                  'Your Program Type:',
                  textAlign: TextAlign.center,
                  style: _t(18, FontWeight.w600, _ink.withValues(alpha: .8)),
                ),
                const SizedBox(height: 0),
                SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'You’re Enrolled In: ',
                            style: _t(18, FontWeight.w400, soft),
                          ),
                          TextSpan(
                            text: programType,
                            style: _t(18, FontWeight.w700, soft),
                          ),
                        ],
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 34),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: Material(
                    color: _ink.withValues(alpha: .8),
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: onGetStarted,
                      borderRadius: BorderRadius.circular(16),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: _t(18, FontWeight.w500, Colors.white),
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
