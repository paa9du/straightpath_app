import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _ink = Color(0xFF101720);

TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
  fontFamily: 'Manrope',
  fontSize: size,
  fontWeight: w,
  color: c,
);

/// "Add a Youth" dialog (Figma 516:971). Background: 5px blur + ink @ 30 %.
class AddYouthDialog extends StatefulWidget {
  const AddYouthDialog({super.key});

  static Future<void> show() {
    return Get.generalDialog<void>(
      barrierDismissible: true,
      barrierLabel: 'Add a youth',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (context, animation, secondary) => const AddYouthDialog(),
      transitionBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: Get.back<void>,
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
            ),
            FadeTransition(opacity: curved, child: child),
          ],
        );
      },
    );
  }

  @override
  State<AddYouthDialog> createState() => _AddYouthDialogState();
}

class _AddYouthDialogState extends State<AddYouthDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Center(
          child: MediaQuery.withNoTextScaling(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(15, 17, 15, 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Add a Youth',
                      style: _t(18, FontWeight.w800, _ink.withValues(alpha: .8)),
                    ),
                  ),
                  const SizedBox(height: 29),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      'Youth Unique ID/Username',
                      style: _t(14, FontWeight.w600, _ink.withValues(alpha: .8)),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _ink.withValues(alpha: .1)),
                    ),
                    child: TextField(
                      controller: _controller,
                      cursorColor: _ink,
                      style: _t(14, FontWeight.w600, _ink),
                      decoration: InputDecoration(
                        hintText: '@nathan_hunt',
                        hintStyle: _t(14, FontWeight.w600, _ink.withValues(alpha: .5)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      children: [
                        Expanded(
                          child: _DialogButton(
                            label: 'Cancel',
                            outlined: true,
                            onTap: Get.back<void>,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _DialogButton(
                            label: 'Add Youth',
                            // Static UI: closes the dialog.
                            onTap: Get.back<void>,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
    return SizedBox(
      height: 54,
      child: Material(
        color: outlined ? Colors.transparent : _ink.withValues(alpha: .8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: outlined ? const BorderSide(color: _ink) : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: _t(18, FontWeight.w500, outlined ? _ink : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
