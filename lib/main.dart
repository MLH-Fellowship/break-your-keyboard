import 'package:flutter/material.dart';

import 'core/dependency_injection/setup_locator.dart';
import 'core/navigation/route_generator.dart';
import 'core/service/context/context_provider_i.dart';
import 'module/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Break Your Keyboard',
      theme: ThemeData.dark(),
      initialRoute: HomePage.route,
      navigatorKey: sl<ContextProviderI>().getNavigationKey(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
