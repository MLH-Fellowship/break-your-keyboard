import 'package:flutter/material.dart';

import '../../../models/player_model.dart';
import '../../game/widgets/small_player_info.dart';

class PlayerList extends StatelessWidget {
  final List<PlayerModel> players;

  const PlayerList({Key key, this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView.builder(
        itemCount: players.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return SmallPlayerInfo(player: players[index]);
        },
      ),
    );
  }
}
