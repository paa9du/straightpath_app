import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../constants/app_constants.dart';

abstract final class ResponsiveUtils {
  static double widthScale(BuildContext context) => math.min(
    MediaQuery.sizeOf(context).width / AppConstants.designWidth,
    1.15,
  );

  static double value(BuildContext context, double designValue) =>
      designValue * widthScale(context);

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 600;
}
