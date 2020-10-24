import 'package:flutter/material.dart';

import '../colors.dart';
import 'base_button.dart';

class BorderedButton extends BaseButton {
  final String buttonLabel;
  final Function() onClick;
  final bool isEnable;

  const BorderedButton(
      {@required this.buttonLabel,
      @required this.onClick,
      this.isEnable = true,
      Key key})
      : super(
          infoColor: Colors.white,
          buttonColor: Colors.transparent,
          borderColor: AppColors.whiteColor,
          buttonDisabledColor: AppColors.darkGrey,
          borderDisabledColor: AppColors.whiteColor,
          infoDisabledColor: AppColors.whiteColor,
          labelBt: buttonLabel,
          onClickBt: onClick,
          isEnableBt: isEnable ?? false,
          key: key,
        );
}
