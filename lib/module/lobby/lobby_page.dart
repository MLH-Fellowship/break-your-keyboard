import 'package:flutter/material.dart';

import '../../models/player_model.dart';
import '../../presentation/app_bar_mobile_only.dart';
import '../../presentation/buttons/button_bordered.dart';
import '../../presentation/buttons/full_color_blue_button.dart';
import '../../presentation/dimensions.dart';
import '../../presentation/text_styles.dart';
import '../base/base_view.dart';
import 'lobby_view_model.dart';

class LobbyPage extends StatefulWidget {
  static const route = 'lobby_page';

  const LobbyPage({Key key}) : super(key: key);

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LobbyViewModel>(
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
                    const SizedBox(height: 120),
                    StreamBuilder<List<PlayerModel>>(
                        stream: model.playersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<PlayerModel>> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading');
                          }
                          return Text(snapshot.data.length.toString());
                        }),
                    FullColorBlueButton(
                        onClick: model.onClickCreateGame, buttonLabel: 'Start'),
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
}
