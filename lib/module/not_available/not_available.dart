import 'package:flutter/material.dart';

import '../../presentation/app_bar_mobile_only.dart';
import '../../presentation/dimensions.dart';

class NotAvailablePage extends StatefulWidget {
  final String route;

  const NotAvailablePage({Key key, this.route}) : super(key: key);

  @override
  _WidgetState createState() => _WidgetState();
}

class _WidgetState extends State<NotAvailablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarForMobileOnly(),
      body: Padding(
        padding: AppDimensions.allPagePadding,
        child: Text('Route: ${widget.route} doesn\'t exist' ?? ''),
      ),
    );
  }
}
