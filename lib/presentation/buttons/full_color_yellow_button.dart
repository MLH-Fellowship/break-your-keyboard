import 'package:flutter/material.dart';

import '../colors.dart';
import 'base_button.dart';

class FullColorYellowButton extends BaseButton {
  final String buttonLabel;
  final Function() onClick;
  final bool isEnable;

  const FullColorYellowButton(
      {@required this.buttonLabel,
      @required this.onClick,
      this.isEnable = true,
      Key key})
      : super(
            infoColor: AppColors.blackColor,
            buttonColor: AppColors.canaryColor,
            borderColor: AppColors.canaryColor,
            buttonDisabledColor: AppColors.canaryColor,
            borderDisabledColor: AppColors.canaryColor,
            infoDisabledColor: AppColors.blackColor,
            labelBt: buttonLabel,
            onClickBt: onClick,
            isEnableBt: isEnable ?? false,
            boxShadow: const BoxShadow(
              color: Color.fromARGB(150, 255, 0, 0),
              spreadRadius: -6,
              blurRadius: 15,
              offset: Offset(0, 9), // changes position of shadow
            ),
            key: key);
}
