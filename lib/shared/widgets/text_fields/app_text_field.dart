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
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final String? prefixAsset;
  final String? suffixAsset;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    Widget? assetIcon(String? asset) => asset == null
        ? null
        : Padding(
            padding: const EdgeInsets.all(18),
            child: SvgPicture.asset(asset, width: 22, height: 22),
          );

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge
            ?.copyWith(color: AppColors.muted),
        prefixIcon: assetIcon(prefixAsset),
        suffixIcon: suffixAsset == null
            ? null
            : IconButton(
                onPressed: onSuffixTap,
                icon: SvgPicture.asset(suffixAsset!, width: 22, height: 22),
              ),
      ),
    );
  }
}
