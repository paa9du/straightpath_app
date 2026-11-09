import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../skills_model.dart';

const _ink = Color(0xFF101720);

TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: w,
      color: c,
    );

/// Common bottom drawer for every "How do you feel" card on the Skills screen.
class FeelingSheet extends StatelessWidget {
  const FeelingSheet({required this.feeling, super.key});

  final FeelingInfo feeling;

  static Future<void> show(FeelingInfo feeling) {
    return Get.generalDialog<void>(
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (context, animation, secondary) =>
          FeelingSheet(feeling: feeling),
      transitionBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
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
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curved),
                child: Material(type: MaterialType.transparency, child: child),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * .88;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(feeling.emojiAsset, width: 60, height: 60),
                const SizedBox(height: 8),
                Text(
                  feeling.title,
                  textAlign: TextAlign.center,
                  style: _t(18, FontWeight.w600, _ink.withValues(alpha: .8)),
                ),
                const SizedBox(height: 24),
                Text(
                  'Recommended Skills',
                  style: _t(18, FontWeight.w500, _ink.withValues(alpha: .8)),
                ),
                const SizedBox(height: 14),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: feeling.skills.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) =>
                        _SkillTile(skill: feeling.skills[i]),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: Get.back<void>,
                    style: FilledButton.styleFrom(
                      backgroundColor: _ink.withValues(alpha: .8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: _t(18, FontWeight.w500, Colors.white),
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

class _SkillTile extends StatelessWidget {
  const _SkillTile({required this.skill});

  final FeelingSkill skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ink.withValues(alpha: .1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill.title,
            style: _t(15, FontWeight.w700, _ink.withValues(alpha: .8)),
          ),
          const SizedBox(height: 8),
          Text(
            skill.description,
            style: _t(12, FontWeight.w400, _ink.withValues(alpha: .7))
                .copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
