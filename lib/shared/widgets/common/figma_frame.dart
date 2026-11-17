import 'package:flutter/material.dart';

/// Lays [child] out on a fixed-width design canvas (the Figma frame width)
/// and scales it to the available width, so text breaks and spacing match
/// the design on any phone. Taps, scrolling and text input keep working.
class FigmaFrame extends StatelessWidget {
  const FigmaFrame({required this.child, this.designWidth = 430, super.key});

  final Widget child;
  final double designWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final scale = box.maxWidth / designWidth;
        return FittedBox(
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: designWidth,
            height: box.maxHeight / scale,
            child: child,
          ),
        );
      },
    );
  }
}
