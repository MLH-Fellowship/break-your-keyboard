import 'package:flutter/material.dart';

import '../../core/service/router/router_i.dart';
import '../../models/player_model.dart';
import '../../models/room_model.dart';
import '../../repository/game_repository_i.dart';
import '../base/base_view_model.dart';

class LobbyViewModel extends BaseViewModel {
  RouterI router;
  GameRepositoryI repository;
  String _joinCode;
  bool _joiningAnExistingRoom; // ignore: unused_field

  LobbyViewModel({
    @required this.router,
    @required this.repository,
  });

  set joinCode(String joinCode) {
    _joinCode = joinCode;
  }

  set joiningAnExistingRoom(bool value) {
    _joiningAnExistingRoom = value;
  }

  Stream<RoomModel> get roomStream {
    return repository.getRoomStream(_joinCode);
  }

  Stream<List<PlayerModel>> get playersStream {
    return repository.getRoomPlayersStream(_joinCode);
  }

  void onClickBack() {
    router.pop();
  }

  void onClickStartGame() {}
}
