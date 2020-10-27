import 'package:flutter/material.dart';

import '../../../presentation/app_bar_mobile_only.dart';
import '../../../presentation/dimensions.dart';
import '../../../presentation/text_styles.dart';
import '../../base/base_view.dart';
import '../widgets/counter_decorated_box.dart';
import '../widgets/tap_and_key_listener.dart';
import '../widgets/traffic_light.dart';
import 'practice_mode_view_model.dart';

class PracticeModePage extends StatefulWidget {
  static const route = 'practice_mode_page';

  const PracticeModePage({Key key}) : super(key: key);

  @override
  _PracticeModePageState createState() => _PracticeModePageState();
}

class _PracticeModePageState extends State<PracticeModePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PracticeModeViewModel>(
      onModelReady: (model) => model.initializeTimer(),
      builder: (context, model, child) => Scaffold(
        appBar: const AppBarForMobileOnly(),
        body: Center(
          child: Container(
            width: AppDimensions.getContainerWidth(context),
            padding: AppDimensions.allPagePadding,
            child: Column(
              mainAxisAlignment: AppDimensions.containerMainAxisAlignment,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
