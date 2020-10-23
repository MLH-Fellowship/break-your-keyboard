import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/service/utils/misc.dart';
import 'custom_keyboard_listener.dart';

class TapAndKeyListener extends StatefulWidget {
  final Function onTapOrKeyPressCallback;
  final bool isEnabled;

  const TapAndKeyListener(
      {this.onTapOrKeyPressCallback, Key key, this.isEnabled = true})
      : super(key: key);

  @override
  _TapAndKeyListenerState createState() => _TapAndKeyListenerState();
}

class _TapAndKeyListenerState extends State<TapAndKeyListener> {
  int _tapCount = 0;

  // this is only used to measure speed.
  // cannot be used for the actual game timer
  double _startClickingTime = 0;
  int _speed = 0;

  int measureSpeed() {
    final timePassed = Misc.currentTimeInSeconds() - _startClickingTime;
    return ((_tapCount / timePassed) * 60).round(); // actions per minute
  }

  void invokeAction() {
    if (!widget.isEnabled) return;

    // check if this is the first tap
    if (_startClickingTime == 0) {
      _startClickingTime = Misc.currentTimeInSeconds();
    }

    setState(() {
      _tapCount++;
      _speed = measureSpeed();
    });

    widget.onTapOrKeyPressCallback();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomKeyboardListener(
      onAction: invokeAction,
      child: AbsorbPointer(
        absorbing: !widget.isEnabled,
        child: InkWell(
          onTap: invokeAction,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            height: min(screenHeight * 0.35, 800),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  offset: Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, min(255, _tapCount + 120), 15, 50),
                  Color.fromARGB(255, min(195, _tapCount + 45), 10,
                      max(60, _tapCount ~/ 3 + 10))
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _tapCount.toString(),
                    style: TextStyle(fontSize: 59),
                  ),
                  Text(
                    '${_speed.toString()} apm',
                    style: TextStyle(fontSize: 38, color: Colors.lime),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
