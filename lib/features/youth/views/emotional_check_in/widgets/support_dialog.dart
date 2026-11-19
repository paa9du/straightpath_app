import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _ink = Color(0xFF101720);

TextStyle _t(double size, FontWeight w, Color c) =>
    TextStyle(fontFamily: 'Manrope', fontSize: size, fontWeight: w, color: c);

/// "Would you like some support right now?" dialog (Figma 873:3393).
/// Background: 5px blur + ink @ 30 % overlay (Figma 254:1819).
class SupportDialog extends StatelessWidget {
  const SupportDialog({
    required this.onContinue,
    required this.onSupport,
    super.key,
  });

  final VoidCallback onContinue;
  final VoidCallback onSupport;

  static Future<void> show({
    required VoidCallback onContinue,
    required VoidCallback onSupport,
  }) {
    return Get.generalDialog<void>(
      barrierDismissible: true,
      barrierLabel: 'Support',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (context, animation, secondary) =>
          SupportDialog(onContinue: onContinue, onSupport: onSupport),
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
    // Laid out on Figma's 390-wide card and scaled down as one piece on
    // narrower phones, so text keeps the same padding inside the buttons.
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
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Would You Like Some Support Right Now?',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: _t(
                            18,
                            FontWeight.w600,
                            _ink.withValues(alpha: .8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 305),
                      child: Text(
                        'A Short Grounding Exercise Might Help Before Continuing.',
                        textAlign: TextAlign.center,
                        style: _t(
                          14,
                          FontWeight.w500,
                          _ink.withValues(alpha: .5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 23),
                    // Figma 873:3396: outlined "Yes, Help Me" (155) on the left,
                    // filled "Continue Anyway" (189) on the right.
                    Row(
                      children: [
                        Expanded(
                          flex: 155,
                          child: _DialogButton(
                            label: 'Yes, Help Me',
                            onTap: onSupport,
                            outlined: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 189,
                          child: _DialogButton(
                            label: 'Continue Anyway',
                            onTap: onContinue,
                          ),
                        ),
                      ],
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

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.onTap,
    this.outlined = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return SizedBox(
      height: 54,
      child: Material(
        color: outlined ? Colors.transparent : _ink.withValues(alpha: .8),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: outlined ? const BorderSide(color: _ink) : BorderSide.none,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  style: _t(
                    18,
                    FontWeight.w500,
                    outlined ? _ink : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
