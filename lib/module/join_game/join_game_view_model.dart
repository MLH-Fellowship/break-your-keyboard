import 'package:flutter/material.dart';

import '../../core/service/error_message/error_message_provider_i.dart';
import '../../core/service/router/router_i.dart';
import '../../repository/game_repository_i.dart';
import '../base/base_view_model.dart';

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

  Future<void> onClickJoinGame({@required String joinCode}) async {
    setIsLoadingTo(true);

    if (joinCode.isEmpty) {
      errorMessageProvider.showSnackBar('Provide a join code!');
      setIsLoadingTo(false);
      return;
    }

    final doesRoomExists = await repository.doesRoomExists(joinCode);
    setIsLoadingTo(false);

    if (!doesRoomExists) {
      errorMessageProvider.showSnackBar('Room does not exist!');
    } else {
      errorMessageProvider.showSnackBar('Joining the room. TODO!');
    }
  }
}
