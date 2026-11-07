import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Color(0xFFF2F2F2)),
        Positioned.fill(
          child: SvgPicture.asset(
            AppAssets.waves,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child,
      ],
    );
  }
}
