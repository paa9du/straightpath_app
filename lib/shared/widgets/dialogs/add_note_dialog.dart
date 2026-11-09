import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/title_case.dart';

const _ink = Color(0xFF101720);

TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
  fontFamily: 'Manrope',
  fontSize: size,
  fontWeight: w,
  color: c,
);

/// "Add a Note" drawer (Figma 375:1004). Background: 5px blur + ink @ 30 %.
class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({
    required this.controller,
    required this.onSubmit,
    this.date = '5 Feb, 2025',
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final String date;

  static Future<void> show({
    required TextEditingController controller,
    required VoidCallback onSubmit,
    String date = '5 Feb, 2025',
  }) {
    return Get.generalDialog<void>(
      barrierDismissible: true,
      barrierLabel: 'Add a note',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (context, animation, secondary) => AddNoteDialog(
        controller: controller,
        onSubmit: onSubmit,
        date: date,
      ),
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
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Center(
          child: SingleChildScrollView(
            child: MediaQuery.withNoTextScaling(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.fromLTRB(15, 18, 15, 19),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        children: [
                          Text(
                            titleCase('Add a Note'),
                            style: _t(18, FontWeight.w800, _ink.withValues(alpha: .8)),
                          ),
                          const Spacer(),
                          Text(
                            date,
                            style: _t(18, FontWeight.w400, _ink.withValues(alpha: .5)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      titleCase('Add a detailed note for the Youth'),
                      style: _t(14, FontWeight.w500, _ink.withValues(alpha: .8)),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _ink.withValues(alpha: .1)),
                      ),
                      child: TextField(
                        controller: controller,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        cursorColor: _ink,
                        style: _t(14, FontWeight.w500, _ink),
                        decoration: InputDecoration(
                          hintText: 'Enter Here...',
                          hintStyle: _t(14, FontWeight.w500, _ink.withValues(alpha: .2)),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        children: [
                          Expanded(
                            child: _Button(
                              label: 'Cancel',
                              outlined: true,
                              onTap: Get.back<void>,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _Button(label: 'Submit', onTap: onSubmit),
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
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.label, required this.onTap, this.outlined = false});

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
