import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/title_case.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';

/// Colours from Figma 147-149.
abstract final class WeeklyColors {
  static const slate900 = Color(0xFF0F172A);
  static const slate600 = Color(0xFF475569);
  static const navy = Color(0xFF0A192F);
  static const dateBadge = Color(0xFFD5F1E9);
  static const dateBadgeText = Color(0xFF10564B);
  static const statusCard = Color(0xFFEDFAF7);
  static const statusCardBorder = Color(0x99CCFBF1);
  static const cardBorder = Color(0xFFF1F5F9);
}

TextStyle weeklyText(
  double size, {
  FontWeight weight = FontWeight.w500,
  Color? color,
  double? height,
  double? letterSpacing,
}) => TextStyle(
  fontFamily: 'Manrope',
  fontSize: size,
  fontWeight: weight,
  height: height,
  letterSpacing: letterSpacing,
  color: color ?? AppColors.ink,
);

/// Date badge + centred day title and description (Figma 757:1885).
class WeeklyDayHeading extends StatelessWidget {
  const WeeklyDayHeading({
    required this.date,
    required this.title,
    required this.description,
    super.key,
  });

  final String date;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 17.64, vertical: 6.62),
          decoration: BoxDecoration(
            color: WeeklyColors.dateBadge,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            date,
            style: weeklyText(
              13.23,
              weight: FontWeight.w700,
              color: WeeklyColors.dateBadgeText,
              height: 17.64 / 13.23,
              letterSpacing: -0.33,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          textAlign: TextAlign.center,
          style: weeklyText(
            22,
            weight: FontWeight.w700,
            color: WeeklyColors.slate900,
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: 308,
          child: Text(
            titleCase(description),
            textAlign: TextAlign.center,
            style: weeklyText(
              14,
              weight: FontWeight.w400,
              color: WeeklyColors.slate600,
              height: 22 / 14,
            ),
          ),
        ),
      ],
    );
  }
}

/// Mint status banner (Figma 757:1813 "Completed!", 760:2111 "Complete 2
/// Questions"): 380 wide, #EDFAF7, pale teal border.
class WeeklyStatusCard extends StatelessWidget {
  const WeeklyStatusCard({
    required this.height,
    required this.child,
    super.key,
  });

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: WeeklyColors.statusCard,
          borderRadius: BorderRadius.circular(17.37),
          border: Border.all(color: WeeklyColors.statusCardBorder, width: 1.09),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 1.09),
              blurRadius: 2.17,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// Bottom action (Figma 760:2299): 60 tall, 16 radius, ink at 80%,
/// Medium 18 white label, 20px from the screen edges.
class WeeklyBottomButton extends StatelessWidget {
  const WeeklyBottomButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: AppPrimaryButton(
        label: label,
        height: 60,
        radius: 16,
        color: AppColors.ink.withValues(alpha: .8),
        textStyle: weeklyText(18, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
