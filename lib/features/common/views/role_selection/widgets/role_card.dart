import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/title_case.dart';
import '../../../../../shared/widgets/common/app_press_effect.dart';
import '../role_selection_model.dart';

/// Role card, built on the Figma 390 x 220 frame and scaled uniformly.
/// Selected = yellow (#FFEE8C), idle = white.
class RoleCard extends StatelessWidget {
  const RoleCard({
    required this.role,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final UserRole role;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressEffect(
      child: AspectRatio(
        aspectRatio: 390 / 220,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: selected ? AppColors.yellow : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 390,
                  height: 220,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned(
                        left: 20,
                        top: 16,
                        child: Text(
                          role.title,
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 53,
                        width: 148,
                        child: Text(
                          titleCase(role.description),
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 15,
                            height: 24 / 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.ink.withValues(alpha: .8),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 168,
                        top: 10,
                        width: 200,
                        height: 200,
                        child: ClipRect(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: role.imageTop,
                                width: 200,
                                height: 300,
                                child: Image.asset(
                                  role.assetPath,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
