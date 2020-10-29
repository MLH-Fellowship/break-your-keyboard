import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../presentation/buttons/full_color_blue_button.dart';
import '../../presentation/buttons/full_color_button.dart';
import '../../presentation/buttons/full_color_yellow_button.dart';
import '../../presentation/decorations.dart';
import '../../presentation/dimensions.dart';
import '../../presentation/misc/separator.dart';
import '../../presentation/text_styles.dart';
import '../base/base_view.dart';
import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  static const route = 'home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: AppDecorations.backgroundDecoration,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: SafeArea(
              child: Padding(
                padding: AppDimensions.leftRightPagePadding,
                child: Center(
                  child: Container(
                    width: AppDimensions.getContainerWidth(context),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'FINGER GAMES',
                            style: AppTextStyles.headerTextStyle,
                          ),
                          const SizedBox(height: 120),
                          FullColorYellowButton(
                              buttonLabel: 'CREATE ROOM',
                              onClick: model.onClickCreateGame),
                          const SizedBox(height: 40),
                          const Separator(),
                          const SizedBox(height: 40),
                          FullColorBlueButton(
                            buttonLabel: 'JOIN ROOM',
                            onClick: model.onClickJoinGame,
                          ),
                          const SizedBox(height: 20),
                          FullColorButton(
                            buttonLabel: 'PRACTICE MODE',
                            onClick: model.onClickPracticeMode,
                          )
                        ],
                      ),
                    ),
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
