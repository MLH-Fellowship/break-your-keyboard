import 'package:flutter/material.dart';

import '../../core/service/error_message/error_message_provider_i.dart';
import '../../core/service/router/router_i.dart';
import '../../models/player_model.dart';
import '../../models/room_model.dart';
import '../../repository/game_repository_i.dart';
import '../base/base_view_model.dart';
import '../game/multiplayer_mode/multiplayer_mode_page.dart';

class LobbyViewModel extends BaseViewModel {
  RouterI router;
  GameRepositoryI repository;
  ErrorMessageProviderI errorMessageProvider;

  String _joinCode;

  LobbyViewModel({
    @required this.router,
    @required this.repository,
    @required this.errorMessageProvider,
  });

  Stream<List<PlayerModel>> get playersStream {
    return repository.getRoomPlayersStream(_joinCode);
  }

  void onClickBack() {
    router.pop();
  }

  Future<void> onClickStartGame() async {
    //TODO: shouldn't join start game with players < 2

    final bool isSuccess = await repository.startGame(_joinCode);
    if (isSuccess) {
      final room = await repository.getRoom(_joinCode);
      startGame(room);
    } else {
      errorMessageProvider.showSnackBar('Error while starting the game');
    }
  }

  void listenIfGameStarts() {
    repository.getRoomStream(_joinCode).listen((room) {
      if (room.startTime != null) startGame(room);
    });
  }

  void startGame(RoomModel room) {
    router.routeReplacementTo(MultiPlayerModePage.route, arg: room);
  }

  void initialize(String joinCode, bool isHost) {
    _joinCode = joinCode;
    if (!isHost) listenIfGameStarts();
  }
}
