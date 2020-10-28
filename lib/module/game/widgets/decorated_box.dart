import 'dart:math';

import 'package:flutter/material.dart';

class DecoratedBoxWidget extends StatelessWidget {
  const DecoratedBoxWidget({
    Key key,
    @required Widget body,
    @required Function() onTap,
  })  : _body = body,
        _onTap = onTap,
        super(key: key);

  final Widget _body;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: _onTap,
      child: Ink(
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
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 30, 30, 30),
              Color.fromARGB(255, 10, 10, 10),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
            stops: [0.0, 1],
          ),
        ),
        child: _body,
      ),
    );
  }
}
