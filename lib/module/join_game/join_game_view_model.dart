import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/service/error_message/error_message_provider_i.dart';
import '../../core/service/router/router_i.dart';
import '../../core/service/utils/misc.dart';
import '../../models/player_model.dart';
import '../../models/room_model.dart';
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
    final joinCodeUppercase = joinCode.toUpperCase();
    setIsLoadingTo(true);

    if (joinCodeUppercase.isEmpty) {
      errorMessageProvider.showSnackBar('Provide a join code!');
      setIsLoadingTo(false);
      return;
    }

    final nicknameValidationMessage = Misc.validateNickname(nickname);
    if (nicknameValidationMessage != '') {
      errorMessageProvider.showSnackBar(nicknameValidationMessage);
      setIsLoadingTo(false);
      return;
    }

    final doesRoomExists = await repository.doesRoomExists(joinCodeUppercase);
    setIsLoadingTo(false);

    if (!doesRoomExists) {
      errorMessageProvider.showSnackBar('Room does not exist!');
      return;
    }

    final RoomModel room = await repository.getRoom(joinCodeUppercase);
    if (!room.isJoinable) {
      errorMessageProvider.showSnackBar('This game is no longer joinable');
      return;
    }

    // TODO: we need to have a player limit

    final PlayerModel myself = PlayerModel(
        name: nickname,
        isHost: false,
        clicks: 0,
        id: FirebaseAuth.instance.currentUser.uid,
        speed: 0);

    await repository.addPlayerToRoom(
        joinCode: joinCodeUppercase, player: myself);

    await router.routeTo(LobbyPage.route,
        arg: LobbyPageArgs(joinCode: joinCodeUppercase, isHost: false));
  }
}
