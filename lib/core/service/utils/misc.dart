class Misc {
  static double currentTimeInSeconds() {
    final ms = DateTime.now().millisecondsSinceEpoch;
    return ms / 1000;
  }

  static int currentTimeInMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
