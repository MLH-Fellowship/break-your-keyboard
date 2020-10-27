import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/service/error_message/error_message_provider_i.dart';
import '../../../core/service/router/router_i.dart';
import '../../../core/service/utils/misc.dart';
import '../../../models/traffic_color.dart';
import '../../../repository/game_repository_i.dart';
import '../../base/base_view_model.dart';

class MultiPlayerModeViewModel extends BaseViewModel {
  GameRepositoryI repository;
  RouterI router;
  ErrorMessageProviderI errorMessageProvider;
  MultiPlayerModeViewModel({
    @required this.repository,
    @required this.router,
    @required this.errorMessageProvider,
  });

  TrafficColor _activeLight = TrafficColor.red;
  int _tapCount = 0;
  double _startClickingTime = 0;
  int _speed = 0;
  Timer _trafficLightTimer;

  bool get isGameStarted => _activeLight == TrafficColor.green;
  TrafficColor get activeLight => _activeLight;
  int get speed => _speed;
  int get tapCount => _tapCount;

  int _measureSpeed() {
    final timePassed = Misc.currentTimeInSeconds() - _startClickingTime;
    return ((_tapCount / timePassed) * 60).round(); // actions per minute
  }

  void _incrementActiveLightIndex() {
    _activeLight = TrafficColor.values[_activeLight.index + 1];
    notifyListeners();
  }

  void onClickIncrement() {
    if (!isGameStarted) return;

    if (_startClickingTime == 0) {
      _startClickingTime = Misc.currentTimeInSeconds();
    }

    _tapCount++;
    _speed = _measureSpeed();
    notifyListeners();
  }

  void initializeTimer(DateTime startTime) {
    _trafficLightTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (DateTime.now().isAfter(startTime)) {
          _incrementActiveLightIndex();

          if (_activeLight == TrafficColor.green) {
            timer.cancel();
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_trafficLightTimer != null) _trafficLightTimer.cancel();
  }
}
