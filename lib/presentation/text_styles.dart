import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

// ignore: avoid_classes_with_only_static_members
class AppTextStyles {
  static const TextStyle headerTextStyle = TextStyle(
      color: AppColors.whiteColor,
      fontSize: 48,
      fontFamily: AppFonts.cabin,
      fontWeight: FontWeight.w700);

  static const TextStyle buttonDarkTextStyle = TextStyle(
      color: AppColors.blackColor,
      fontSize: 24,
      fontFamily: AppFonts.cabin,
      fontWeight: FontWeight.w700);
}
