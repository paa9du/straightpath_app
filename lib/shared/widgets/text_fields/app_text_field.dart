import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.hintText,
    this.prefixAsset,
    this.suffixAsset,
    this.obscureText = false,
    this.onSuffixTap,
    this.keyboardType,
    this.compact = false,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final String? prefixAsset;
  final String? suffixAsset;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType;

  /// Figma auth-form variant: 60px tall, 17px text, 24px icons.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 24.0 : 22.0;
    Widget? assetIcon(String? asset) => asset == null
        ? null
        : Padding(
            padding: const EdgeInsets.all(18),
            child: SvgPicture.asset(asset, width: iconSize, height: iconSize),
          );
    final base = Theme.of(context).textTheme.bodyLarge!;
    final textStyle = compact
        ? base.copyWith(fontSize: 17, height: 1.3)
        : base;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hintText,
        constraints: compact ? const BoxConstraints(minHeight: 60) : null,
        contentPadding: compact
            ? const EdgeInsets.symmetric(horizontal: 18, vertical: 19)
            : null,
        hintStyle: textStyle.copyWith(
          color: compact ? AppColors.ink.withValues(alpha: .5) : AppColors.muted,
        ),
        prefixIcon: assetIcon(prefixAsset),
        suffixIcon: suffixAsset == null
            ? null
            : compact
                ? InkWell(
                    onTap: onSuffixTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 18, 23, 18),
                      child: SvgPicture.asset(suffixAsset!,
                          width: iconSize, height: iconSize),
                    ),
                  )
                : IconButton(
                    onPressed: onSuffixTap,
                    icon: SvgPicture.asset(suffixAsset!, width: 22, height: 22),
                  ),
      ),
    );
  }
}
