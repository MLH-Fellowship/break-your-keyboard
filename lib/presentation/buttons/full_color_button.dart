import 'package:flutter/material.dart';

import '../colors.dart';
import 'base_button.dart';

class FullColorButton extends BaseButton {
  final Color buttonFullColor;
  final String buttonLabel;
  final Function() onClick;
  final bool isEnable;

  const FullColorButton({
    this.buttonFullColor = AppColors.whiteColor,
    @required this.buttonLabel,
    @required this.onClick,
    this.isEnable = true,
    Key key

  }) : super(
      infoColor: AppColors.blackColor,
      buttonColor: buttonFullColor,
      borderColor: buttonFullColor,
      buttonDisabledColor: buttonFullColor,
      borderDisabledColor: buttonFullColor,
      infoDisabledColor: AppColors.blackColor,
      labelBt: buttonLabel,
      onClickBt: onClick,
      isEnableBt: isEnable ?? false,
      key: key
  );
}
