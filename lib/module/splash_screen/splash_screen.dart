import 'package:flutter/material.dart';

import '../../presentation/progress_indicator_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: ProgressIndicatorWidget(),
      ),
    );
  }
}
