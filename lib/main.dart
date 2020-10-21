import 'package:flutter/material.dart';

import 'core/navigation/route_generator.dart';
import 'module/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: HomePage.route,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
