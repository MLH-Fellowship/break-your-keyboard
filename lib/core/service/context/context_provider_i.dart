import 'package:flutter/material.dart';

abstract class ContextProviderI {
  BuildContext getBuildContext();

  GlobalKey<NavigatorState> getNavigationKey();
}