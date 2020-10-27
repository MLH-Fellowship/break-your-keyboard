import 'package:flutter/material.dart';

import '../../../models/player_model.dart';
import '../../../models/room_model.dart';
import '../../../presentation/app_bar_mobile_only.dart';
import '../../../presentation/dimensions.dart';
import '../../../presentation/text_styles.dart';
import '../../base/base_view.dart';
import '../widgets/counter_decorated_box.dart';
import '../widgets/tap_and_key_listener.dart';
import '../widgets/traffic_light.dart';
import 'multiplayer_mode_view_model.dart';

class MultiPlayerModePage extends StatefulWidget {
  static const route = 'multiplayer_mode_page';
  final RoomModel currentRoom;
  const MultiPlayerModePage({Key key, @required this.currentRoom})
      : super(key: key);

  @override
  _MultiPlayerModePageState createState() => _MultiPlayerModePageState();
}

class _MultiPlayerModePageState extends State<MultiPlayerModePage> {
  //TODO: Handle OnWillPop
  @override
  Widget build(BuildContext context) {
    return BaseView<MultiPlayerModeViewModel>(
      onModelReady: (model) => model.initialize(widget.currentRoom),
      builder: (context, model, child) => Scaffold(
        appBar: const AppBarForMobileOnly(),
        body: Center(
          child: Container(
            width: AppDimensions.getContainerWidth(context),
            padding: AppDimensions.allPagePadding,
            child: Column(
              mainAxisAlignment: AppDimensions.containerMainAxisAlignment,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'PRACTICE MODE',
                        style: AppTextStyles.headerTextStyle,
                      ),
                      const SizedBox(height: 40),
                      TrafficLight(activeLight: model.activeLight),
                      const SizedBox(height: 40),
                      TapAndKeyListener(
                          isEnabled: model.isGameStarted,
                          body: CounterDecoratedBox(
                              tapCount: model.tapCount, speed: model.speed),
                          invokeAction: model.onClickIncrement),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                playerListBuilder(model),
              ],
            ),
          ),
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
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          return Text(snapshot.hasData && snapshot.data.length > 1
              ? 'first: ${snapshot.data.first.toJson()} -- last: ${snapshot.data.last.toJson()}'
              : 'no data');
        });
  }
}
