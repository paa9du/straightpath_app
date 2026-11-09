import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Figma confirm dialog: #F6F6F6 card, radius 16, Cancel (outlined) + dark action.
class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onConfirm,
    super.key,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback onConfirm;

  static const _ink = Color(0xFF101720);

  static TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
        fontFamily: 'Manrope',
        fontSize: size,
        fontWeight: w,
        color: c,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF6F6F6),
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: _t(18, FontWeight.w600, _ink.withValues(alpha: .8)),
            ),
            const SizedBox(height: 22),
            for (final line in message.split('\n'))
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  line,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: _t(14, FontWeight.w500, _ink.withValues(alpha: .5))
                      .copyWith(height: 1.5),
                ),
              ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: OutlinedButton(
                      onPressed: Get.back<void>,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: _ink),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Cancel', style: _t(18, FontWeight.w500, _ink)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed: onConfirm,
                      style: FilledButton.styleFrom(
                        backgroundColor: _ink.withValues(alpha: .8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          confirmLabel,
                          style: _t(18, FontWeight.w500, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
