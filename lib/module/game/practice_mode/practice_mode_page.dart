import 'package:flutter/material.dart';

import '../../../presentation/dimensions.dart';
import '../widgets/tap_and_key_listener.dart';
import '../widgets/traffic_light.dart';

class PracticeModePage extends StatefulWidget {
  static const route = 'practice_mode_page';

  const PracticeModePage({Key key}) : super(key: key);

  @override
  _PracticeModePageState createState() => _PracticeModePageState();
}

class _PracticeModePageState extends State<PracticeModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice mode'),
      ),
      body: Center(
        child: Container(
          width: AppDimensions.getContainerWidth(context),
          padding: AppDimensions.allPagePadding,
          child: Column(
            mainAxisAlignment: AppDimensions.containerMainAxisAlignment,
            children: const [
              TrafficLight(),
              SizedBox(height: 40),
              TapAndKeyListener(),
            ],
          ),
        ),
      ),
    );
  }
}
