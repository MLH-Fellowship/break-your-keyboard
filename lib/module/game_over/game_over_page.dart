import 'package:flutter/material.dart';

class GameOverPage extends StatelessWidget {
  static const route = 'game_over_page';

  const GameOverPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Game is over!'),
      ),
    );
  }
}
