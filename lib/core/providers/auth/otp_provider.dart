import 'package:flutter/material.dart';

class OtpProvider with ChangeNotifier {
  final FocusNode pinputFocusNode = FocusNode();
  bool _hasError = false;

  bool get hasError => _hasError;

  // update error state
  void setHasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  // validate the OTP input
  void validateOtp(value) {
    setHasError(value.length != 4);
  }
}
