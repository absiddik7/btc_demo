import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mybtccanvas/core/models/auth/user_model.dart';
import 'package:mybtccanvas/core/services/base_service.dart';
import 'package:mybtccanvas/core/services/local_storage/app_sharedpreference.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService extends BaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a new user
  Future<UserModel> register(Map<String, String> userData) async {
    try {
      final response = await post('/auth/register', userData);

      if (response.data['status'] == 'success') {
        // Return a UserModel object
        return UserModel.fromJson(response.data);
      } else {
        // If status is not success, show the error message
        final errorMessage = response.data['message'] ?? 'Registration failed';
        throw errorMessage.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Sign in with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Get the current user
      User? user = userCredential.user;
      if (user != null) {
        // Get the ID token
        String? idToken = await user.getIdToken();
        // Save the session token in shared preferences
        await AppSharedPreferences().saveIDToken(idToken!);
      }
      return userCredential.user;
    } catch (e) {
      throw 'Failed to sign in with Google';
    }
  }

  // Future<UserCredential> signInWithApple() async {
  //   try {
  //     final appleProvider = AppleAuthProvider();
  //     return await _auth.signInWithPopup(appleProvider);
  //   } catch (e) {

  //     throw 'Failed to sign in with Apple';
  //   }

  // }
  Future<User?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user == null) {
        throw const (code: 'user-credential-null', message: 'An error occurred. Please try again later.');
      }

      return user;
    } on FirebaseAuthException catch (err) {
      throw (code: err.code, message: 'An error occurred. Please try again later.');
    } on SignInWithAppleAuthorizationException catch (err) {
      switch (err.code) {
        case AuthorizationErrorCode.canceled:
          return null;
        case AuthorizationErrorCode.failed:
          throw (code: 'apple-sign-in-error', message: 'Apple Sign-In error: ${err.message}');
        case AuthorizationErrorCode.invalidResponse:
          throw (code: 'apple-sign-in-error', message: 'Apple Sign-In error: ${err.message}');
        case AuthorizationErrorCode.notHandled:
          throw (code: 'apple-sign-in-error', message: 'Apple Sign-In error: ${err.message}');
        case AuthorizationErrorCode.notInteractive:
          throw (code: 'apple-sign-in-error', message: 'Apple Sign-In error: ${err.message}');
        case AuthorizationErrorCode.unknown:
          throw (code: 'apple-sign-in-error', message: 'Apple Sign-In error: ${err.message}');
      }
    } catch (err) {
      throw const (code: '', message: 'An error occurred. Please try again later.');
    }
  }

  // Sign in with email and password
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in the user
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Get the current user
      User? user = userCredential.user;
      if (user != null) {
        // Get the ID token
        String? idToken = await user.getIdToken();
        // Save the session token
        await AppSharedPreferences().saveIDToken(idToken!);
        return idToken;
      }

      // Return null if no user is found
      return null;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase error codes
      switch (e.code) {
        case 'invalid-credential':
          throw 'Invalid credentials.';
        case 'user-not-found':
          throw 'No user found for that email.';
        case 'wrong-password':
          throw 'The password is incorrect.';
        case 'invalid-email':
          throw 'The email address is not valid.';
        default:
          throw 'Something went wrong.';
      }
    } catch (e) {
      // Handle unexpected errors
      throw 'Something went wrong.';
    }
  }

  // Sign out the user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'Something went wrong!';
    }
  }
}
