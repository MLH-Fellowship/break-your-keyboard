import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarForMobileOnly extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarForMobileOnly({Key key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return !kIsWeb ? AppBar() : Container(width: 0, height: 0);
  }
}
