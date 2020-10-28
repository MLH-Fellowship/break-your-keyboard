import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/service/error_message/error_message_provider_i.dart';
import '../../core/service/router/router_i.dart';
import '../../core/service/utils/consts.dart';
import '../../core/service/utils/misc.dart';
import '../../models/player_model.dart';
import '../../repository/game_repository_i.dart';
import '../base/base_view_model.dart';
import '../lobby/lobby_page.dart';

class CreateGameViewModel extends BaseViewModel {
  RouterI router;
  GameRepositoryI repository;
  ErrorMessageProviderI errorMessageProvider;
  CreateGameViewModel(
      {@required this.router,
      @required this.repository,
      @required this.errorMessageProvider});

  void onClickBack() {
    router.pop();
  }

  Future<void> onClickCreateGame(String nickname, int duration) async {
    try {
      setIsLoadingTo(true);

      final String joinCode =
          Misc.getRandomString(Consts.joinCodeLength).toUpperCase();

      final nicknameValidationMessage = Misc.validateNickname(nickname);
      if (nicknameValidationMessage != '') {
        errorMessageProvider.showSnackBar(nicknameValidationMessage);
        setIsLoadingTo(false);
        return;
      }

      final PlayerModel host = PlayerModel(
        id: FirebaseAuth.instance.currentUser.uid,
        clicks: 0,
        speed: 0,
        isHost: true,
        name: nickname,
      );
      await repository.createRoom(
          joinCode: joinCode, duration: duration, host: host);

      setIsLoadingTo(false);
      await router.routeTo(LobbyPage.route,
          arg: LobbyPageArgs(joinCode: joinCode));
    } on Exception {
      errorMessageProvider
          .showSnackBar('Oops, something went wrong. Try again!');
    } finally {
      setIsLoadingTo(false);
    }
  }
}
