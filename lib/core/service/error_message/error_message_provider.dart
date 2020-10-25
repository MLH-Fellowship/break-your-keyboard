import 'package:fluttertoast/fluttertoast.dart';

import '../../../presentation/colors.dart';
import 'error_message_provider_i.dart';

class ErrorMessageProvider implements ErrorMessageProviderI {
  @override
  void showSnackBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        webPosition: 'center',
        webBgColor: AppColors.redColor.toString(),
        fontSize: 16.0);
  }
}
