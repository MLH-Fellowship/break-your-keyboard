import 'dart:math';

import 'package:flutter/material.dart';

class CounterDecoratedBox extends StatelessWidget {
  const CounterDecoratedBox({
    Key key,
    @required int tapCount,
    @required int speed,
  }) : _tapCount = tapCount, _speed = speed, super(key: key);

  final int _tapCount;
  final int _speed;

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
            Color.fromARGB(255, min(255, _tapCount + 120), 15, 50),
            Color.fromARGB(255, min(195, _tapCount + 45), 10,
                max(60, _tapCount ~/ 3 + 10))
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
