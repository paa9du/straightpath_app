import 'package:flutter/material.dart';

/// Adds an obvious tactile treatment without owning the tap callback.
/// Place it around an InkWell, button, or other existing interactive widget.
class AppPressEffect extends StatefulWidget {
  const AppPressEffect({
    required this.child,
    this.enabled = true,
    this.pressedScale = .97,
    super.key,
  });

  final Widget child;
  final bool enabled;
  final double pressedScale;

  @override
  State<AppPressEffect> createState() => _AppPressEffectState();
}

class _AppPressEffectState extends State<AppPressEffect> {
  var _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: Listener(
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: AnimatedScale(
          scale: _pressed ? widget.pressedScale : 1,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: _pressed ? .86 : 1,
            duration: const Duration(milliseconds: 90),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
