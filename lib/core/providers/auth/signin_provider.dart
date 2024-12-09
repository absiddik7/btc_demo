import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mybtccanvas/core/models/auth/user_model.dart';
import 'package:mybtccanvas/core/services/auth/auth_service.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';

class SignInProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isEmailValidationStarted = false;
  bool _isPasswordsValidationStarted = false;
  bool get isEmailValidationStarted => _isEmailValidationStarted;
  bool get isPasswordsValidationStarted => _isPasswordsValidationStarted;

  User? _user;
  User? get user => _user;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  // Toggle email validation
  void setEmailValidationStarted(bool value) {
    _isEmailValidationStarted = value;
    notifyListeners();
  }

  // Toggle password validation
  void setPasswordValidationStarted(bool value) {
    _isPasswordsValidationStarted = value;
    notifyListeners();
  }

  // Email Validators
  String? emailValidator(BuildContext? context, String? value) {
    if (value == null || value.isEmpty) {
      return context?.lang.email_empty_error;
    }
    final RegExp emailRegExp = RegExp(
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return context?.lang.email_invalid_error;
    }
    return null;
  }

  // Password Validators
  String? passwordValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.lang.password_empty_error;
    }
    return null;
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
    try {
      // Authenticate with Firebase and get the ID token
      String? idToken = await signInWithEmailAndPassword(email, password);
      if (idToken == null) {
        throw 'Unable to fetch ID token.';
      }

      // Send the ID token to the backend for login
      UserModel user = await _authService.login(idToken);

      // Optionally, save user details or notify listeners
      print("User successfully logged in: ${user.data.firstName} ${user.data.lastName}");
    } catch (e) {
      // Handle errors and propagate if necessary
      throw e.toString();
    }
  }

  Future<void> loginUserWithSocial(BuildContext context, Future<String?> Function() socialSignInMethod) async {
  try {
    // Perform social sign-in and retrieve the ID token
    String? idToken = await socialSignInMethod();
    if (idToken == null) throw 'Social sign-in failed.';

    // Send the ID token to the backend for login
    UserModel user = await _authService.login(idToken);

    // Optionally, save user details or notify listeners
    print("User successfully logged in: ${user.data.firstName} ${user.data.lastName}");
  } catch (e) {
    // Handle errors and propagate if necessary
    throw e.toString();
  }
}


  // Sign in with email and password
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      String? idToken = await _authService.signInWithEmailAndPassword(email, password);
      return idToken;
    } catch (e) {
      return null;
    }
  }

  // Sign in with Google
  Future<String?> signInWithGoogle() async {
    try {
      _user = await _authService.signInWithGoogle();
      return await _user?.getIdToken();
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  // Sign in with Apple
  Future<void> signInWithApple() async {
    try {
      await _authService.signInWithApple();
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  // Sign out
  Future<void> logout() async {
    try {
      await _authService.logout();
      // Sign out from Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      notifyListeners();
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}
