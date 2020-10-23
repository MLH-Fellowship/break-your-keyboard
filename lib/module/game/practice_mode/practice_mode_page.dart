import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/service/utils/misc.dart';
import '../../../presentation/dimensions.dart';
import '../widgets/counter_decorated_box.dart';
import '../widgets/tap_and_key_listener.dart';
import '../widgets/traffic_light.dart';

class PracticeModePage extends StatefulWidget {
  static const route = 'practice_mode_page';

  const PracticeModePage({Key key}) : super(key: key);

  @override
  _PracticeModePageState createState() => _PracticeModePageState();
}

class _PracticeModePageState extends State<PracticeModePage> {
  TrafficColor _activeLight = TrafficColor.red;
  int _tapCount = 0;
  double _startClickingTime = 0;
  int _speed = 0;
  bool get _isGameStarted => _activeLight == TrafficColor.green;

  int measureSpeed() {
    final timePassed = Misc.currentTimeInSeconds() - _startClickingTime;
    return ((_tapCount / timePassed) * 60).round(); // actions per minute
  }

  void invokeAction() {
    if (!_isGameStarted) return;

    if (_startClickingTime == 0) {
      _startClickingTime = Misc.currentTimeInSeconds();
    }

    setState(() {

      _tapCount++;
      _speed = measureSpeed();
    });
  }

  void incrementActiveLightIndex() {
    setState(() {
      _activeLight = TrafficColor.values[_activeLight.index + 1];
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        incrementActiveLightIndex();
        if (_activeLight == TrafficColor.green) timer.cancel();
      },
    );
  }

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
            children: [
              TrafficLight(activeLight: _activeLight),
              const SizedBox(height: 40),
              TapAndKeyListener(
                  isEnabled: _isGameStarted,
                  body: CounterDecoratedBox(tapCount: _tapCount, speed: _speed),
                  invokeAction: invokeAction),
            ],
          ),
        ),
      ),
    );
  }
}
