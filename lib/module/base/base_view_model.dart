import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoadingTo(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
