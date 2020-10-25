import 'package:flutter/material.dart';

import '../../../core/dependency_injection/setup_locator.dart';
import '../../../core/service/router/router_i.dart';
import '../../../presentation/buttons/button_bordered.dart';
import '../../../presentation/buttons/full_color_blue_button.dart';
import '../../../presentation/dimensions.dart';
import '../../../presentation/inputs/text_field_outlined.dart';
import '../../../presentation/text_styles.dart';
import '../widgets/game_time_selector.dart';

class CreateGamePage extends StatefulWidget {
  static const route = 'create_game_page';

  const CreateGamePage({Key key}) : super(key: key);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final _nicknameController = TextEditingController();
  final _maxPlayersController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nicknameController.dispose();
  }

  void goBack() {
    getIts<RouterI>().pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppDimensions.allPagePadding,
        child: Center(
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
              TextFieldOutlined(
                hintText: 'Max players (2-10)',
                controller: _maxPlayersController,
              ),
              const SizedBox(height: 15),
              GameTimeSelector(onChanged: (String value) {}),
              const SizedBox(height: 35),
              FullColorBlueButton(onClick: () {}, buttonLabel: 'Create'),
              const SizedBox(height: 15),
              BorderedButton(onClick: goBack, buttonLabel: 'Back'),
            ],
          ),
        ),
      ),
    );
  }
}