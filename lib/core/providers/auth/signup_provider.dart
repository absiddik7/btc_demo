import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/models/auth/user_model.dart';
import 'package:mybtccanvas/core/services/auth/auth_service.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';

class SignupProvider with ChangeNotifier {
  bool _isFullnameEmailValidationStarted = false;
  bool _isPasswordsValidationStarted = false;
  bool get isFullnameEmailValidationStarted => _isFullnameEmailValidationStarted;
  bool get isPasswordsValidationStarted => _isPasswordsValidationStarted;

  void setFullnameEmailValidationStarted(bool value) {
    _isFullnameEmailValidationStarted = value;
    notifyListeners();
  }

  void setPasswordValidationStarted(bool value) {
    _isPasswordsValidationStarted = value;
    notifyListeners();
  }

  // Email validation
  String? emailValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.email_empty_error;
    }
    final RegExp emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegExp.hasMatch(value)) {
      return context.lang.email_invalid_error;
    }
    return null;
  }

  // Name validation logic
  String? nameValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.name_empty_error;
    }
    return null;
  }

  // Password validation
  String? passwordValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.password_empty_error;
    }
    if (value.length < 6) {
      return context.lang.password_length_error;
    }
    return null;
  }

  // Confirm password validation
  String? confirmPasswordValidator(BuildContext context, String? value, String? password) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value != password) {
      return context.lang.password_match_error;
    }
    return null;
  }

  // User model
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  // Function to register user via AuthService
  Future<void> registerUser(BuildContext context, Map<String, String> userData) async {
    try {
      // Call the service for registration
      _userModel = await _authService.register(userData);
      
      // Do any additional tasks (e.g., store user data, notify listeners, etc.)
      print("User registered: ${_userModel?.data.firstName} ${_userModel?.data.lastName}");
      
      // Notify UI about changes if needed
      notifyListeners();
    } catch (e) {
      // Handle errors and propagate if necessary
      print('Error in SignupProvider: $e');
      throw e.toString();
    }
  }


  // Social signup logic
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> signInWithGoogle() async {
    try {
      _user = await _authService.signInWithGoogle();
      notifyListeners();
    } catch (e) {
      print('Error in AuthProvider: $e');
      throw e.toString(); // Re-throw to handle in the UI
    }
  }
  
}
