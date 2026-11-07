import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    required this.title,
    required this.onBack,
    this.trailing,
    super.key,
  });

  final String title;
  final VoidCallback onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            ),
          ),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          if (trailing != null)
            Align(alignment: Alignment.centerRight, child: trailing!),
        ],
      ),
    );
  }
}
