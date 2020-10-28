import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/player_model.dart';
import '../../../presentation/colors.dart';

class SmallPlayerInfo extends StatelessWidget {
  final PlayerModel player;
  final bool hasGameStarted;
  const SmallPlayerInfo({Key key, this.player, this.hasGameStarted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: SVG's are not working for web. Fix avatars for web
    return SizedBox(
      child: Card(
        color: player.isHost ? AppColors.redColor.withOpacity(0.2) : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              // ignore: avoid_redundant_argument_values
              flex: kIsWeb ? 1 : 2,
              child: kIsWeb
                  ? placeHolderAvatarForWeb()
                  : SvgPicture.network(
                      player.getAvatarUrl(),
                      height: 40,
                    ),
            ),
            Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  player.name,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  Widget placeHolderAvatarForWeb() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Center(
        child: Text(
          player.name[0].toUpperCase(),
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
