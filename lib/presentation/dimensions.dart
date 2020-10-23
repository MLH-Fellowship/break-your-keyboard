import 'dart:math';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppDimensions {
  static const double _pagePaddingValue = 32;

  static const EdgeInsets allPagePadding = EdgeInsets.all(_pagePaddingValue);

  static const EdgeInsets leftRightPagePadding =
      EdgeInsets.only(left: _pagePaddingValue, right: _pagePaddingValue);

  static double getContainerWidth(BuildContext context) {
    return min(MediaQuery.of(context).size.width, 500);
  }

  static MainAxisAlignment containerMainAxisAlignment =
      kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start;
}
