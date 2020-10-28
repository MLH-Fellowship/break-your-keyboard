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
    return InkWell(
      onTap: _onTap,
      child: Ink(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 45, 50),
              Color.fromARGB(255, 195, 50, 60)
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
