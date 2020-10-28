import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/service/error_message/error_message_provider_i.dart';
import '../../../core/service/router/router_i.dart';
import '../../../core/service/utils/consts.dart';
import '../../../core/service/utils/misc.dart';
import '../../../models/player_model.dart';
import '../../../models/room_model.dart';
import '../../../models/traffic_color.dart';
import '../../../repository/game_repository_i.dart';
import '../../base/base_view_model.dart';
import '../../lobby/lobby_page.dart';

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
  double _startClickingTime = 0;
  int _speed = 0;
  Timer _trafficLightTimer;
  Timer _updateClicksTimer;
  final int _updateIntervalInSeconds = Consts.multiplayerUpdateInterval;
  bool _isGameOver = false;
  bool _isHost;
  TrafficColor get activeLight => _activeLight;

  bool get isGameStarted => activeLight == TrafficColor.green;
  bool get isGameOver => _isGameOver;
  int get speed => _speed;
  int get tapCount => _tapCount;
  DateTime get endTime => _currentRoom.endTimeObj;
  int get duration => _currentRoom.duration;

  void endGame() {
    _isGameOver = true;
    _activeLight = TrafficColor.red;
    notifyListeners();
  }

  Future<void> onPlayAgainClick() async {
    await repository.resetGame(joinCode: _currentRoom.joinCode);
    await router.routeTo(LobbyPage.route,
        arg: LobbyPageArgs(joinCode: _currentRoom.joinCode, isHost: _isHost));
  }

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

  void initialize(RoomModel currentRoom, bool isHost) {
    _currentRoom = currentRoom;
    _isHost = isHost;
    final double trafficLightTimerInterval =
        _currentRoom.startTimeObj.difference(DateTime.now()).inSeconds / 3;

    // By splitting the interval into 3, we're compensating for any lag
    // in between opening screens, or phone slowness.
    // Splitting in 3 because 3 traffic lights
    _trafficLightTimer = Timer.periodic(
      Duration(milliseconds: (trafficLightTimerInterval * 1000).toInt()),
      (timer) {
        _incrementActiveLightIndex();

        if (_activeLight == TrafficColor.green) {
          timer.cancel();
          notifyListeners();
        }
      },
    );

    _updateClicksTimer = Timer.periodic(
      Duration(seconds: _updateIntervalInSeconds),
      (timer) async {
        if (DateTime.now().isAfter(_currentRoom.startTimeObj)) {
          await updateUserClicks();

          if (DateTime.now().isAfter(_currentRoom.startTimeObj
              .add(Duration(seconds: _currentRoom.duration))
              .subtract(const Duration(
                  seconds: Consts.offsetLagAdjustmentSeconds)))) {
            timer.cancel();
            endGame();
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
