import 'package:flutter/material.dart';

import '../../core/service/router/router_i.dart';
import '../base/base_view_model.dart';
import '../lobby/lobby_page.dart';

class CreateGameViewModel extends BaseViewModel {
  RouterI router;

  CreateGameViewModel({@required this.router});

  void onClickBack() {
    router.pop();
  }

  void onClickCreateGame() {
    router.routeTo(LobbyPage.route);
  }
}
