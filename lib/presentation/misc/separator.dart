import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: 190,
      color: Colors.grey.withOpacity(0.2),
    );
  }
}
