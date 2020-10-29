import 'package:flutter/material.dart';

import '../../core/service/utils/consts.dart';
import '../../presentation/app_bar_mobile_only.dart';
import '../../presentation/buttons/button_bordered.dart';
import '../../presentation/buttons/full_color_blue_button.dart';
import '../../presentation/decorations.dart';
import '../../presentation/dimensions.dart';
import '../../presentation/inputs/text_field_outlined.dart';
import '../../presentation/text_styles.dart';
import '../base/base_view.dart';
import 'join_game_view_model.dart';

class JoinPage extends StatefulWidget {
  static const route = 'join_page';

  const JoinPage({Key key}) : super(key: key);

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _joinCodeController = TextEditingController();
  final _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO: Handle OnWillPop
    return BaseView<JoinGameViewModel>(
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
                        'JOIN A GAME',
                        style: AppTextStyles.headerTextStyle,
                      ),
                      const SizedBox(height: 150),
                      TextFieldOutlined(
                        hintText: 'Nickname',
                        maxLength: Consts.maxNicknameLength,
                        controller: _nicknameController,
                      ),
                      const SizedBox(height: 15),
                      TextFieldOutlined(
                        hintText: 'Join code',
                        maxLength: Consts.joinCodeLength,
                        capitalized: true,
                        controller: _joinCodeController,
                      ),
                      const SizedBox(height: 35),
                      FullColorBlueButton(
                          onClick: () async => model.onClickJoinGame(
                              nickname: _nicknameController.text,
                              joinCode: _joinCodeController.text),
                          isEnable: !model.isLoading,
                          buttonLabel: model.isLoading ? 'Loading...' : 'Join'),
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

  @override
  void dispose() {
    super.dispose();
    _joinCodeController.dispose();
    _nicknameController.dispose();
  }
}
