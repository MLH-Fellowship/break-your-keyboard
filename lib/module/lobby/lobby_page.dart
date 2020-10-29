import 'package:flutter/material.dart';

import '../../models/player_model.dart';
import '../../presentation/app_bar_mobile_only.dart';
import '../../presentation/buttons/button_bordered.dart';
import '../../presentation/buttons/full_color_blue_button.dart';
import '../../presentation/colors.dart';
import '../../presentation/decorations.dart';
import '../../presentation/dimensions.dart';
import '../../presentation/progress_indicator_widget.dart';
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
        body: Container(
          decoration: AppDecorations.backgroundDecoration,
          child: Padding(
            padding: AppDimensions.allPagePadding,
            child: Center(
              child: Container(
                width: AppDimensions.getContainerWidth(context),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: AppDimensions.containerMainAxisAlignment,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //ignore: avoid_redundant_argument_values
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Code:',
                            style: AppTextStyles.headerTextStyle.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(joinCode,
                              style: AppTextStyles.headerTextStyle.copyWith(
                                color: AppColors.yellowColor,
                              )),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          'Game time: ${model.gameDuration} seconds',
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      ),
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
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const ProgressIndicatorWidget(),
            );
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
