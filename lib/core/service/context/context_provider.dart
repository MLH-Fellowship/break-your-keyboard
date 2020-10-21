import 'package:flutter/material.dart';

import 'context_provider_i.dart';

class ContextProvider implements ContextProviderI {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  BuildContext getBuildContext() {
    return navigatorKey.currentContext;
  }

  @override
  GlobalKey<NavigatorState> getNavigationKey() {
    return navigatorKey;
  }
}