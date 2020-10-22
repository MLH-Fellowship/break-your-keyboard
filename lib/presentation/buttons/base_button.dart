import 'package:flutter/material.dart';

import '../text_styles.dart';

class BaseButton extends StatelessWidget {
  final String labelBt;
  final Function() onClickBt;
  final bool isEnableBt;

  final Color buttonColor;
  final Color buttonDisabledColor;
  final Color infoColor;
  final Color infoDisabledColor;

  final Color borderColor;
  final Color borderDisabledColor;

  const BaseButton(
      {@required this.labelBt,
      @required this.buttonColor,
      @required this.buttonDisabledColor,
      @required this.infoColor,
      @required this.infoDisabledColor,
      @required this.borderColor,
      @required this.borderDisabledColor,
      @required this.onClickBt,
      this.isEnableBt,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      colorBrightness: Brightness.dark,
      disabledColor: buttonDisabledColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: isEnableBt ? borderColor : borderDisabledColor)),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      color: buttonColor,
      onPressed: isEnableBt ? onClickBt : null,
      child: Container(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox.shrink(),
            Text(
              labelBt ?? '',
              style: AppTextStyles.buttonDarkTextStyle.copyWith(
                color: isEnableBt ? infoColor : infoDisabledColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
