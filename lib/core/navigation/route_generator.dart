import 'package:flutter/material.dart';

import '../../models/room_model.dart';
import '../../module/create_game/create_game_page.dart';
import '../../module/game/multiplayer_mode/multiplayer_mode_page.dart';
import '../../module/game/practice_mode/practice_mode_page.dart';
import '../../module/home/home_page.dart';
import '../../module/join_game/join_game_page.dart';
import '../../module/lobby/lobby_page.dart';
import '../../module/not_available/not_available.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.route:
        return _navigate(const HomePage());

      case PracticeModePage.route:
        return _navigate(const PracticeModePage());

      case JoinPage.route:
        return _navigate(const JoinPage());

      case CreateGamePage.route:
        return _navigate(const CreateGamePage());

      case LobbyPage.route:
        return _navigate(LobbyPage(
          args: routeSettings.arguments as LobbyPageArgs,
        ));

      case MultiPlayerModePage.route:
        return _navigate(MultiPlayerModePage(
          currentRoom: routeSettings.arguments as RoomModel,
        ));

      default:
        return _navigate(NotAvailablePage(route: routeSettings.name));
    }
  }

  static MaterialPageRoute _navigate(Widget widget) {
    return MaterialPageRoute<dynamic>(builder: (context) => widget);
  }
}
