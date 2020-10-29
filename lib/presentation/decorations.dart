import 'package:flutter/material.dart';

import 'images.dart';

class AppDecorations {
  static const BoxDecoration backgroundDecoration = BoxDecoration(
    image: DecorationImage(
        image: NetworkImage(AppImages.backgroundNetworkImage),
        fit: BoxFit.fill),
  );
}
