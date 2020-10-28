import 'dart:math';

import 'consts.dart';

// ignore: avoid_classes_with_only_static_members
class Misc {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static double currentTimeInSeconds() {
    final ms = DateTime.now().millisecondsSinceEpoch;
    return ms / 1000;
  }

  static int currentTimeInMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String validateNickname(String nickname) {
    if (nickname.isEmpty) {
      return 'Nickname cannot be empty';
    }

    if (nickname.length > Consts.maxNicknameLength) {
      return 'Nickname can\'t have more than ${Consts.maxNicknameLength} letters';
    }
    return '';
  }
}
