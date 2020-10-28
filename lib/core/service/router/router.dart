import 'package:flutter/material.dart';

import '../context/context_provider_i.dart';
import 'router_i.dart';

class Router implements RouterI {
  final ContextProviderI contextProvider;

  Router({@required this.contextProvider});

  @override
  Future<dynamic> routeTo(String routeName, {Object arg}) {
    return contextProvider
        .getNavigationKey()
        .currentState
        .pushNamed(routeName, arguments: arg);
  }

  @override
  Future<dynamic> routeReplacementTo(String routeName, {Object arg}) {
    return contextProvider
        .getNavigationKey()
        .currentState
        .pushReplacementNamed(routeName, arguments: arg);
  }

  @override
  void pop() {
    return contextProvider.getNavigationKey().currentState.pop();
  }
}
