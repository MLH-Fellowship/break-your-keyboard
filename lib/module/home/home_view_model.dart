import '../../core/dependency_injection/setup_locator.dart';
import '../../core/service/router/router_i.dart';
import '../base/base_view_model.dart';
import '../create_game/create_game_page.dart';
import '../game/practice_mode/practice_mode_page.dart';
import '../join_game/join_game_page.dart';

class HomeViewModel extends BaseViewModel {
  final RouterI _router = getIts<RouterI>();

  void onClickPracticeMode() {
    _router.routeTo(PracticeModePage.route);
  }

  void onClickJoinGame() {
    _router.routeTo(JoinPage.route);
  }

  void onClickCreateGame() {
    _router.routeTo(CreateGamePage.route);
  }
}