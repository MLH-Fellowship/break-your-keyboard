import 'package:flutter/material.dart';

class Misc {
  static double currentTimeInSeconds() {
    final ms = DateTime.now().millisecondsSinceEpoch;
    return ms / 1000;
  }

  static int currentTimeInMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static void showSnackbar(BuildContext ctx, String text) {
    Scaffold.of(ctx).showSnackBar(const SnackBar(
      content: Text('Provide a join code!'),
    ));
  }
}
