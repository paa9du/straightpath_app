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
    this.height = 50,
    this.color,
    this.textStyle,
    this.radius,
    super.key,
  });

  /// Corner radius; defaults to [AppRadii.card].
  final double? radius;

  /// Overrides the label style; defaults to `labelLarge` at 15px.
  final TextStyle? textStyle;

  /// Solid background; defaults to [AppColors.ink]. Ignored when [gradient].
  final Color? color;

  final String label;
  final VoidCallback? onPressed;
  final bool gradient;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppPressEffect(
      enabled: onPressed != null,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: gradient ? null : (color ?? AppColors.ink),
            gradient: gradient ? AppColors.primaryGradient : null,
            borderRadius: BorderRadius.circular(radius ?? AppRadii.card),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(radius ?? AppRadii.card),
              child: Center(
                child: Text(
                  label,
                  style: textStyle ??
                      Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
