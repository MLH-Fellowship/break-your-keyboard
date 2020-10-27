import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/service/error_message/error_message_provider_i.dart';
import '../../../core/service/router/router_i.dart';
import '../../../core/service/utils/misc.dart';
import '../../../models/player_model.dart';
import '../../../models/room_model.dart';
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

  RoomModel _currentRoom;
  TrafficColor _activeLight = TrafficColor.red;
  int _tapCount = 0;
  int _tapCountAtPreviousUpdate = 0;
  double _startClickingTime = 0;
  int _speed = 0;
  Timer _trafficLightTimer;
  Timer _updateClicksTimer;

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

  void initialize(RoomModel currentRoom) {
    _currentRoom = currentRoom;

    _trafficLightTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (DateTime.now().isAfter(_currentRoom.startTimeObj)) {
          _incrementActiveLightIndex();

          if (_activeLight == TrafficColor.green) {
            timer.cancel();
          }
        }
      },
    );

    _updateClicksTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        if (DateTime.now().isAfter(_currentRoom.startTimeObj)) {
          if (_tapCountAtPreviousUpdate != _tapCount) {
            final _isSuccess = await updateUserClicks();
            print('update was $_isSuccess');

            if (_isSuccess) {
              _tapCountAtPreviousUpdate = _tapCount;
            }
          }

          if (DateTime.now().isAfter(
              DateTime.now().add(Duration(seconds: _currentRoom.duration)))) {
            timer.cancel();

          }
        }
      },
    );
  }

  Stream<List<PlayerModel>> get playersStream {
    return repository.getRoomPlayersStream(_currentRoom.joinCode);
  }

  Future<bool> updateUserClicks() {
    return repository.updateUserClicks(
      speed: _speed,
      playerUid: FirebaseAuth.instance.currentUser.uid,
      clicks: _tapCount,
      joinCode: _currentRoom.joinCode,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _trafficLightTimer?.cancel();
    _updateClicksTimer?.cancel();
  }
}
