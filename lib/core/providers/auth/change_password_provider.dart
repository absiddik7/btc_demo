import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';

class ChangePasswordProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  String? currentPasswordValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.password_empty_error;
    }
    if (value.length < 6) {
      return context.lang.password_length_error;
    }
    return null;
  }

  String? passwordValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.password_empty_error;
    }
    if (value.length < 6) {
      return context.lang.password_length_error;
    }
    return null;
  }

  String? confirmPasswordValidator(BuildContext context, String? value, String? newPassword) {
    if (value == null || value.isEmpty) {
      return context.lang.password_confirm_error;
    }
    if (value != newPassword) {
      return context.lang.password_match_error;
    }
    return null;
  }

  void setButtonEnabled(bool isEnabled) {
    if (isEnabled != _isButtonEnabled) {
      _isButtonEnabled = isEnabled;
      notifyListeners();
    }
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }
}
