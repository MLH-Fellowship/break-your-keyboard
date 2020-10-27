import 'package:flutter/material.dart';

import '../../models/player_model.dart';
import '../../presentation/app_bar_mobile_only.dart';
import '../../presentation/buttons/button_bordered.dart';
import '../../presentation/buttons/full_color_blue_button.dart';
import '../../presentation/dimensions.dart';
import '../../presentation/text_styles.dart';
import '../base/base_view.dart';
import 'lobby_view_model.dart';
import 'widgets/player_list.dart';

class LobbyPage extends StatefulWidget {
  static const route = 'lobby_page';
  final LobbyPageArgs args;

  const LobbyPage({Key key, @required this.args}) : super(key: key);

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  String get joinCode => widget.args.joinCode;
  bool get isHost => widget.args.isHost;

  @override
  Widget build(BuildContext context) {
    return BaseView<LobbyViewModel>(
      onModelReady: (model) => model.initialize(joinCode, isHost),
      builder: (context, model, child) => Scaffold(
        appBar: const AppBarForMobileOnly(),
        body: Padding(
          padding: AppDimensions.allPagePadding,
          child: Center(
            child: Container(
              width: AppDimensions.getContainerWidth(context),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: AppDimensions.containerMainAxisAlignment,
                  children: [
                    const Text(
                      'LOBBY',
                      style: AppTextStyles.headerTextStyle,
                    ),
                    Text('Code: $joinCode',
                        style: AppTextStyles.headerTextStyle),
                    const SizedBox(height: 20),
                    playerListBuilder(model),
                    if (isHost)
                      FullColorBlueButton(
                          onClick: () async => model.onClickStartGame(),
                          buttonLabel: 'Start'),
                    const SizedBox(height: 15),
                    BorderedButton(
                        onClick: model.onClickBack, buttonLabel: 'Back'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<PlayerModel>> playerListBuilder(LobbyViewModel model) {
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
          return PlayerList(players: snapshot.data);
        });
  }
}

@immutable
class LobbyPageArgs {
  final String joinCode;
  final bool isHost;
  const LobbyPageArgs({@required this.joinCode, this.isHost = true});
}
