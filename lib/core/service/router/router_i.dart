abstract class RouterI {
  Future<dynamic> routeTo(String routeName, {Object arg});

  Future<dynamic> routeReplacementTo(String routeName, {Object arg});

  void pop();
}
