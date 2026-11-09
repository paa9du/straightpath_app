import 'package:flutter/material.dart';

/// 64px coral→orange circular action button (Figma "Ellipse 205/206").
class GradientFab extends StatelessWidget {
  const GradientFab({required this.icon, required this.onTap, super.key});

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B6F), Color(0xFFFF9A5A)],
          ),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
