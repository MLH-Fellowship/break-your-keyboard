import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/service/router/router_i.dart';
import '../../core/service/utils/misc.dart';
import '../../models/player_model.dart';
import '../../repository/game_repository_i.dart';
import '../base/base_view_model.dart';
import '../lobby/lobby_page.dart';

class CreateGameViewModel extends BaseViewModel {
  RouterI router;
  GameRepositoryI repository;

  CreateGameViewModel({@required this.router, @required this.repository});

  void onClickBack() {
    router.pop();
  }

  Future<void> onClickCreateGame() async {
    final String joinCode = Misc.getRandomString(4).toUpperCase();
    // TODO: get the username from the view, instead of hardcoding.
    final PlayerModel host = PlayerModel(
      id: FirebaseAuth.instance.currentUser.uid,
      clicks: 0,
      speed: 0,
      isHost: true,
      name: 'TODO!${Misc.getRandomString(2)}',
    );
    await repository.createRoom(joinCode: joinCode, duration: 30, host: host);

    await router.routeTo(LobbyPage.route,
        arg: {'joinCode': joinCode, 'joiningAnExistingGame': false});
  }
}
