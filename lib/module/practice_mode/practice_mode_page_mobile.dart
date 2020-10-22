import 'package:flutter/material.dart';

import '../../presentation/game/traffic_light.dart';

class PracticeModePageMobile extends StatefulWidget {
  static const route = 'practice_mode_page_mobile';
  const PracticeModePageMobile({Key key}) : super(key: key);

  @override
  _PracticeModePageMobileState createState() => _PracticeModePageMobileState();
}

class _PracticeModePageMobileState extends State<PracticeModePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Mode'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return const SingleChildScrollView(
      child: TrafficLight(),
    );
  }
}
