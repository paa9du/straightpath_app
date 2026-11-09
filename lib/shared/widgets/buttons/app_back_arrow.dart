import 'package:flutter/material.dart';

/// Figma "Hicon / Linear / Left 1": 24x24 box, 1.5 stroke, #2D264B.
class AppBackArrow extends StatelessWidget {
  const AppBackArrow({this.size = 24, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CustomPaint(painter: _BackArrowPainter()),
    );
  }
}

class _BackArrowPainter extends CustomPainter {
  const _BackArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / 24;
    final paint = Paint()
      ..color = const Color(0xFF2D264B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 * k
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(20 * k, 12 * k)
      ..lineTo(4 * k, 12 * k)
      ..moveTo(9.5 * k, 7 * k)
      ..lineTo(4 * k, 12 * k)
      ..lineTo(9.5 * k, 17 * k);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
