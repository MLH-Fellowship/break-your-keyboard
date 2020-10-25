import 'package:flutter/cupertino.dart';

import '../../core/service/router/router_i.dart';
import '../base/base_view_model.dart';
import '../create_game/create_game_page.dart';
import '../game/practice_mode/practice_mode_page.dart';
import '../join_game/join_game_page.dart';

class HomeViewModel extends BaseViewModel {
  RouterI router;

  HomeViewModel({@required this.router});

  void onClickPracticeMode() {
    router.routeTo(PracticeModePage.route);
  }

  void onClickJoinGame() {
    router.routeTo(JoinPage.route);
  }

  void onClickCreateGame() {
    router.routeTo(CreateGamePage.route);
  }
}
