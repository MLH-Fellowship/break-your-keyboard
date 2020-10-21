import 'package:flutter/material.dart';

import '../colors.dart';
import 'base_button.dart';

class FullColorYellowButton extends BaseButton {
  final String buttonLabel;
  final Function() onClick;
  final bool isEnable;

  const FullColorYellowButton({
    @required this.buttonLabel,
    @required this.onClick,
    this.isEnable = true,
    Key key

  }) : super(
      infoColor: AppColors.blackColor,
      buttonColor: AppColors.canaryColor,
      borderColor: AppColors.canaryColor,
      buttonDisabledColor: AppColors.canaryColor,
      borderDisabledColor: AppColors.canaryColor,
      infoDisabledColor: AppColors.blackColor,
      labelBt: buttonLabel,
      onClickBt: onClick,
      isEnableBt: isEnable ?? false,
      key: key
  );
}
