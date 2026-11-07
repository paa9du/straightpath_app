import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}
