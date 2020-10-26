import 'package:flutter/material.dart';

import '../../core/service/router/router_i.dart';
import '../../models/player_model.dart';
import '../../models/room_model.dart';
import '../../repository/game_repository_i.dart';
import '../base/base_view_model.dart';

class LobbyViewModel extends BaseViewModel {
  RouterI router;
  GameRepositoryI repository;

  LobbyViewModel({
    @required this.router,
    @required this.repository,
  });

  Stream<RoomModel> get roomStream {
    return repository.getRoomStream();
  }

  Stream<List<PlayerModel>> get playersStream {
    return repository.getRoomPlayersStream('');
  }

  void onClickBack() {
    router.pop();
  }

  void onClickCreateGame() {}
}
