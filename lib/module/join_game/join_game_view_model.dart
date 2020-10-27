import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/service/error_message/error_message_provider_i.dart';
import '../../core/service/router/router_i.dart';
import '../../models/player_model.dart';
import '../../repository/game_repository_i.dart';
import '../base/base_view_model.dart';
import '../lobby/lobby_page.dart';

class JoinGameViewModel extends BaseViewModel {
  RouterI router;
  ErrorMessageProviderI errorMessageProvider;
  GameRepositoryI repository;

  JoinGameViewModel({
    @required this.router,
    @required this.errorMessageProvider,
    @required this.repository,
  });

  void onClickBack() {
    router.pop();
  }

  Future<void> onClickJoinGame(
      {@required String nickname, @required String joinCode}) async {
    setIsLoadingTo(true);

    // TODO: join codes need to be case insensitive.
    if (joinCode.isEmpty) {
      errorMessageProvider.showSnackBar('Provide a join code!');
      setIsLoadingTo(false);
      return;
    }

    if (nickname.isEmpty) {
      errorMessageProvider.showSnackBar('Provide a username!');
      setIsLoadingTo(false);
      return;
    }

    final doesRoomExists = await repository.doesRoomExists(joinCode);
    setIsLoadingTo(false);

    if (!doesRoomExists) {
      errorMessageProvider.showSnackBar('Room does not exist!');
      return;
    }

    final PlayerModel myself = PlayerModel(
        name: nickname,
        isHost: false,
        clicks: 0,
        id: FirebaseAuth.instance.currentUser.uid,
        speed: 0);

    //TODO: shouldn't join a room that has startTime!=null

    await repository.addPlayerToRoom(joinCode: joinCode, player: myself);

    await router.routeTo(LobbyPage.route,
        arg: LobbyPageArgs(joinCode: joinCode, isHost: false));
  }
}
