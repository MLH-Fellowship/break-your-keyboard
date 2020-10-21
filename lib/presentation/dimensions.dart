import 'package:flutter/material.dart';

class AppDimensions {
  static const double _pagePaddingValue = 32;

  static const EdgeInsets allPagePadding = EdgeInsets.all(_pagePaddingValue);

  static const EdgeInsets leftRightPagePadding =
      EdgeInsets.only(left: _pagePaddingValue, right: _pagePaddingValue);
}
