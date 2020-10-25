import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'error_message_provider_i.dart';

class ErrorMessageProvider implements ErrorMessageProviderI {
  @override
  void showSnackBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
