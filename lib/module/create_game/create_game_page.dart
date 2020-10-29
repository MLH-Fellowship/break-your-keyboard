import 'package:flutter/material.dart';

import '../../presentation/app_bar_mobile_only.dart';
import '../../presentation/buttons/button_bordered.dart';
import '../../presentation/buttons/full_color_blue_button.dart';
import '../../presentation/decorations.dart';
import '../../presentation/dimensions.dart';
import '../../presentation/inputs/text_field_outlined.dart';
import '../../presentation/text_styles.dart';
import '../base/base_view.dart';
import '../game/widgets/game_time_selector.dart';
import 'create_game_view_model.dart';

class CreateGamePage extends StatefulWidget {
  static const route = 'create_game_page';

  const CreateGamePage({Key key}) : super(key: key);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final _nicknameController = TextEditingController();
  int duration = 10;

  @override
  void dispose() {
    super.dispose();
    _nicknameController.dispose();
  }

  void onDurationChanged(String value) {
    // Split "10 sec" and get the 10
    // There can be a better way to do this.
    duration = int.tryParse(value.split(' ')[0]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateGameViewModel>(
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
                    children: [
                      const Text(
                        'CREATE A GAME',
                        style: AppTextStyles.headerTextStyle,
                      ),
                      const SizedBox(height: 120),
                      TextFieldOutlined(
                        hintText: 'Nickname',
                        controller: _nicknameController,
                      ),
                      const SizedBox(height: 15),
                      GameTimeSelector(onChanged: onDurationChanged),
                      const SizedBox(height: 35),
                      FullColorBlueButton(
                          onClick: () => model.onClickCreateGame(
                              _nicknameController.text, duration),
                          buttonLabel:
                              model.isLoading ? 'Loading...' : 'Create'),
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
}
