import 'dart:async';
import 'package:flutter/material.dart';

class VerifyEmailProvider extends ChangeNotifier {
  Timer? _timer;
  int _start = 30;
  bool _isButtonDisabled = false;

  int get start => _start;
  bool get isButtonDisabled => _isButtonDisabled;

  void startTimer() {
    _isButtonDisabled = true;
    _start = 30; // Reset the countdown to 30 seconds
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        _start--;
      } else {
        _isButtonDisabled = false;
        timer.cancel(); // Stop the timer when it reaches zero
      }
      notifyListeners();
    });
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
