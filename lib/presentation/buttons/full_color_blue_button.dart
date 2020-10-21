import 'package:flutter/material.dart';

import '../colors.dart';
import 'base_button.dart';

class FullColorBlueButton extends BaseButton {
  final String buttonLabel;
  final Function() onClick;
  final bool isEnable;

  const FullColorBlueButton({
    @required this.buttonLabel,
    @required this.onClick,
    this.isEnable = true,
    Key key

  }) : super(
      infoColor: AppColors.blackColor,
      buttonColor: AppColors.skyBlueColor,
      borderColor: AppColors.skyBlueColor,
      buttonDisabledColor: AppColors.skyBlueColor,
      borderDisabledColor: AppColors.skyBlueColor,
      infoDisabledColor: AppColors.blackColor,
      labelBt: buttonLabel,
      onClickBt: onClick,
      isEnableBt: isEnable ?? false,
      key: key
  );
}
