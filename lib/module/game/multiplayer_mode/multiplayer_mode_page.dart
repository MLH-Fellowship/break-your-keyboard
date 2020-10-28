import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../models/player_model.dart';
import '../../../models/room_model.dart';
import '../../../presentation/app_bar_mobile_only.dart';
import '../../../presentation/dimensions.dart';
import '../../base/base_view.dart';
import '../widgets/counter_decorated_box.dart';
import '../widgets/decorated_box.dart';
import '../widgets/horizontal_small_player_info.dart';
import '../widgets/tap_and_key_listener.dart';
import '../widgets/traffic_light.dart';
import 'multiplayer_mode_view_model.dart';

class MultiPlayerModePage extends StatefulWidget {
  static const route = 'multiplayer_mode_page';
  final MultiPlayerGamePageArgs args;
  const MultiPlayerModePage({Key key, @required this.args}) : super(key: key);

  @override
  _MultiPlayerModePageState createState() => _MultiPlayerModePageState();
}

class _MultiPlayerModePageState extends State<MultiPlayerModePage> {
  Widget cachedPlayerList;

  //TODO: Handle OnWillPop
  @override
  Widget build(BuildContext context) {
    return BaseView<MultiPlayerModeViewModel>(
      onModelReady: (model) =>
          model.initialize(widget.args.room, widget.args.isHost),
      builder: (context, model, child) => Scaffold(
        appBar: const AppBarForMobileOnly(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppDimensions.getContainerWidth(context),
              padding: AppDimensions.allPagePadding,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: AppDimensions.containerMainAxisAlignment,
                  children: [
                    Column(
                      children: [
                        CountdownTimer(
                          endTime: model.endTime.millisecondsSinceEpoch - 1000,
                          widgetBuilder: (BuildContext context,
                              CurrentRemainingTime time) {
                            if (time == null || time.sec > model.duration) {
                              return const SizedBox(height: 30);
                            }
                            return SizedBox(
                              height: 30,
                              child: Text(
                                time.sec.toString(),
                                style: const TextStyle(fontSize: 28),
                              ),
                            );
                          },
                        ),
                        if (model.isGameOver)
                          DecoratedBoxWidget(
                            body: const Center(
                                child: Text(
                              'Play Again',
                              style: TextStyle(fontSize: 15),
                              textWidthBasis: TextWidthBasis.parent,
                            )),
                            onTap: model.onPlayAgainClick,
                          ),
                        const SizedBox(height: 10),
                        TrafficLight(activeLight: model.activeLight),
                        const SizedBox(height: 40),
                        TapAndKeyListener(
                            isEnabled: model.isGameStarted,
                            body: CounterDecoratedBox(
                                isEnabled: model.isGameStarted,
                                tapCount: model.tapCount,
                                speed: model.speed),
                            invokeAction: model.onClickIncrement)
                      ],
                    ),
                    const SizedBox(height: 50),
                    playerListBuilder(model),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<PlayerModel>> playerListBuilder(
      MultiPlayerModeViewModel model) {
    return StreamBuilder<List<PlayerModel>>(
        stream: model.playersStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<PlayerModel>> snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            if (cachedPlayerList != null) {
              return cachedPlayerList;
            } else {
              return const Text('Something went terribly wrong');
            }
          }
          final List<PlayerModel> playersList = snapshot.data;
          playersList.sort((a, b) => b.speed.compareTo(a.speed));
          return cachedPlayerList = buildPlayerGrid(playersList);
        });
  }

  Widget buildPlayerGrid(List<PlayerModel> players) {
    return SizedBox(
      width: double.infinity,
      // TODO: we want the player list to expand height to fill the screen
      // Currently it's fixed height, and doesn't look good on web
      height: 175,
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return HorizontalSmallPlayerInfo(player: player);
        },
      ),
    );
  }
}

@immutable
class MultiPlayerGamePageArgs {
  final RoomModel room;
  final bool isHost;
  const MultiPlayerGamePageArgs({@required this.room, @required this.isHost});
}
