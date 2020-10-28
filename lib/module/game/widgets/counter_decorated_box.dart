import 'dart:math';

import 'package:flutter/material.dart';

class CounterDecoratedBox extends StatelessWidget {
  const CounterDecoratedBox({
    Key key,
    @required int tapCount,
    @required int speed,
    bool isEnabled = true,
  })  : _tapCount = tapCount,
        _speed = speed,
        _isEnabled = isEnabled,
        super(key: key);

  final int _tapCount;
  final int _speed;
  final bool _isEnabled;

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return Ink(
      height: min(_screenHeight * 0.35, 800),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            offset: const Offset(0, 10),
            blurRadius: 20,
          ),
        ],
        gradient: LinearGradient(
          colors: [
            ..._isEnabled
                ? [
                    Color.fromARGB(255, min(255, _tapCount + 120), 15, 50),
                    Color.fromARGB(255, min(195, _tapCount + 45), 10,
                        max(60, _tapCount ~/ 3 + 10))
                  ]
                : [
                    const Color.fromARGB(255, 30, 30, 30),
                    const Color.fromARGB(255, 10, 10, 10),
                  ]
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: const [0.0, 1],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              _tapCount.toString(),
              style: const TextStyle(fontSize: 59),
            ),
            Text(
              '${_speed.toString()} apm',
              style: const TextStyle(fontSize: 38, color: Colors.lime),
            )
          ],
        ),
      ),
    );
  }
}
