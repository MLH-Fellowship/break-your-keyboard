import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/dependency_injection/setup_locator.dart';
import 'core/navigation/route_generator.dart';
import 'core/service/context/context_provider_i.dart';
import 'module/home/home_page.dart';
import 'module/splash_screen/error_screen.dart';
import 'module/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _firebaseInitialized = false;
  bool _error = false;

  Future<void> initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
   //   await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        _firebaseInitialized = true;
      });
    } on Exception catch (_) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_firebaseInitialized) {
      return const SplashScreen();
    }

    if (_error) {
      return const ErrorScreen();
    }

    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: FirebaseAuth.instance.authStateChanges(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Break Your Keyboard',
        theme: ThemeData.dark(),
        initialRoute: HomePage.route,
        navigatorKey: sl<ContextProviderI>().getNavigationKey(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
