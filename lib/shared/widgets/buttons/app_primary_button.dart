import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../common/app_press_effect.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    this.gradient = false,
    this.width = double.infinity,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool gradient;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AppPressEffect(
      enabled: onPressed != null,
      child: SizedBox(
        width: width,
        height: 60,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: gradient ? null : AppColors.ink,
            gradient: gradient ? AppColors.primaryGradient : null,
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(AppRadii.card),
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
