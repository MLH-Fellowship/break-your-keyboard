import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/dependency_injection/setup_locator.dart';
import '../../core/service/router/router_i.dart';
import '../../presentation/buttons/full_color_blue_button.dart';
import '../../presentation/buttons/full_color_button.dart';
import '../../presentation/buttons/full_color_yellow_button.dart';
import '../../presentation/dimensions.dart';
import '../../presentation/text_styles.dart';
import '../practice_mode/practice_mode_page.dart';

class HomePage extends StatelessWidget {
  static const route = 'home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Padding(
            padding: AppDimensions.leftRightPagePadding,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'FINGER GAMES',
                      style: AppTextStyles.headerTextStyle,
                    ),
                    const SizedBox(height: 150),
                    FullColorYellowButton(
                        buttonLabel: 'CREATE ROOM', onClick: () {}),
                    const SizedBox(height: 60),
                    FullColorBlueButton(
                        buttonLabel: 'JOIN ROOM', onClick: () {}),
                    const SizedBox(height: 20),
                    FullColorButton(
                        buttonLabel: 'PRACTICE MODE',
                        onClick: () {
                          getIts<RouterI>().routeTo(PracticeModePage.route);
                        }),
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
