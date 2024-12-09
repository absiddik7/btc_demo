import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';

class ForgotPasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String? emailValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.email_empty_error;
    }
    final RegExp emailRegExp = RegExp(
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return context.lang.email_invalid_error;
    }
    return null;
  }

  Future<void> sendResetPasswordEmail(BuildContext context, email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // call api here
      _errorMessage = null;
    } catch (e) {
      _errorMessage = context.lang.email_send_error;
      ;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
