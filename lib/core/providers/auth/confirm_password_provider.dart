import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';

class ConfirmPasswordProvider with ChangeNotifier {
  String? passwordValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.password_empty_error;
    }
    if (value.length < 6) {
      return context.lang.password_length_error;
    }
    return null;
  }

  String? confirmPasswordValidator(BuildContext context, String? value, String password) {
    if (value == null || value.isEmpty) {
      return context.lang.password_confirm_error;
    }
    if (value != password) {
      return context.lang.password_match_error;
    }
    return null;
  }
}
