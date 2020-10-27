import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/player_model.dart';
import '../../../presentation/colors.dart';

class SmallPlayerInfo extends StatelessWidget {
  final PlayerModel player;
  const SmallPlayerInfo({Key key, this.player}) : super(key: key);

  String getHostPrefix() {
    return player.isHost ? '👑 ' : '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: SVG's are not working for web. Fix avatars for web
    return Card(
      color: player.isHost ? AppColors.redColor.withOpacity(0.2) : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: kIsWeb
                ? placeHolderAvatarForWeb()
                : SvgPicture.network(
                    'https://avatars.dicebear.com/api/human/${player.name}.svg',
                    height: 40,
                  ),
          ),
          Expanded(
            child: Text(getHostPrefix() + player.name),
          )
        ],
      ),
    );
  }

  Widget placeHolderAvatarForWeb() {
    return Text(
      player.name,
      style: const TextStyle(fontSize: 28),
    );
  }
}
