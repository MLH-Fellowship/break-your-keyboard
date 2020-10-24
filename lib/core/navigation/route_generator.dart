import 'package:break_your_keyboard/module/game/join_page/join_page.dart';
import 'package:flutter/material.dart';

import '../../module/game/practice_mode/practice_mode_page.dart';
import '../../module/home/home_page.dart';
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

      default:
        return _navigate(NotAvailablePage(route: routeSettings.name));
    }
  }

  static MaterialPageRoute _navigate(Widget widget) {
    return MaterialPageRoute<dynamic>(builder: (context) => widget);
  }
}
