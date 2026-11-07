import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radii.dart';
import '../../../../../shared/widgets/common/app_press_effect.dart';
import '../role_selection_model.dart';

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
      child: Material(
        elevation: selected ? 4 : 1,
        shadowColor: AppColors.coral.withValues(alpha: .25),
        color: selected ? AppColors.yellow : Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.card),
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
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
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 53,
                      width: 150,
                      child: Text(
                        role.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          height: 1.6,
                          color: AppColors.ink.withValues(alpha: .8),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 10,
                      child: Image.asset(
                        role.assetPath,
                        width: 218,
                        height: 218,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
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
