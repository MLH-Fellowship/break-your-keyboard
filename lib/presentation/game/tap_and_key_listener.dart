import 'dart:math';

import 'package:flutter/material.dart';

import '../dimensions.dart';
import 'custom_keyboard_listener.dart';

class TapAndKeyListener extends StatefulWidget {
  final Function onTapOrKeyPressCallback;

  const TapAndKeyListener({this.onTapOrKeyPressCallback, Key key})
      : super(key: key);

  @override
  _TapAndKeyListenerState createState() => _TapAndKeyListenerState();
}

class _TapAndKeyListenerState extends State<TapAndKeyListener> {
  int _tapCount = 0;

  void invokeAction() {
    setState(() {
      _tapCount++;
    });
    widget.onTapOrKeyPressCallback();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomKeyboardListener(
      onAction: invokeAction,
      child: InkWell(
        onTap: invokeAction,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          width: min(screenWidth - AppDimensions.allPagePadding.left * 2, 500),
          height: min(screenHeight * 0.35, 800),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF0000),
                  const Color(0xFFAA0000),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1]),
          ),
          child: Center(
            child: Text(
              _tapCount.toString(),
              style: TextStyle(fontSize: 38),
            ),
          ),
        ),
      ),
    );
  }
}
