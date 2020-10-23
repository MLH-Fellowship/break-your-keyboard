import 'package:flutter/material.dart';

import 'custom_keyboard_listener.dart';

class TapAndKeyListener extends StatelessWidget {
  final bool isEnabled;
  final Function() invokeAction;
  final Widget body;

  const TapAndKeyListener({
    Key key,
    this.isEnabled = true,
    this.body,
    this.invokeAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomKeyboardListener(
      onAction: invokeAction,
      child: AbsorbPointer(
        absorbing: !isEnabled,
        child: InkWell(
          onTap: invokeAction,
          borderRadius: BorderRadius.circular(20),
          child: body,
        ),
      ),
    );
  }
}
