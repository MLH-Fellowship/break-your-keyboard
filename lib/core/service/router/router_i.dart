import '../../navigation/route_argument.dart';

abstract class RouterI {
  Future<dynamic> routeTo(String routeName, {Object arg});

  Future<dynamic> routeReplacementTo(String routeName, {RouteArgument arg});

  void pop();
}
