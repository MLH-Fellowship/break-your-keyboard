import 'package:countup/countup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/service/utils/consts.dart';
import '../../../models/player_model.dart';
import '../../../presentation/dimensions.dart';

class HorizontalSmallPlayerInfo extends StatefulWidget {
  final PlayerModel player;

  const HorizontalSmallPlayerInfo({Key key, @required this.player})
      : super(key: key);

  @override
  _HorizontalSmallPlayerInfoState createState() =>
      _HorizontalSmallPlayerInfoState();
}

PlayerModel oldPlayer;

class _HorizontalSmallPlayerInfoState extends State<HorizontalSmallPlayerInfo> {
  @override
  void didUpdateWidget(HorizontalSmallPlayerInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.player.clicks != widget.player.clicks) {
      _oldPlayerClicks = oldWidget.player.clicks;
    }

    if (oldWidget.player.speed != widget.player.speed) {
      _oldPlayerSpeed = oldWidget.player.speed;
    }
  }

  int _oldPlayerClicks = 0;
  int _oldPlayerSpeed = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: AppDimensions.getContainerWidth(context) * 0.28,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 0,
                        child: kIsWeb
                            ? const SizedBox(width: 0)
                            : SvgPicture.network(widget.player.getAvatarUrl(),
                                height: 25),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(widget.player.name,
                              style: const TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 0,
              child: Container(
                width: 80,
                color: Colors.black12,
                child: Center(
                  child: Countup(
                    begin: _oldPlayerClicks?.toDouble(),
                    end: (widget.player.clicks).toDouble(),
                    duration:
                        const Duration(seconds: Consts.multiplayerUpdateInterval),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 0,
              child: Container(
                width: 80,
                color: Colors.yellow,
                child: Center(
                  child: Countup(
                      begin: _oldPlayerSpeed?.toDouble(),
                      end: (widget.player.speed).toDouble(),
                      duration:
                          const Duration(seconds: Consts.multiplayerUpdateInterval),
                      style: const TextStyle(color: Colors.black)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
