import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bulkpal_mobile/services/auth_service.dart';

class LoginViewModel with ChangeNotifier {
  LoginViewModel({required this.authService});

  final AuthService authService;

  bool isLoading = false;
  String errorMessage = '';

  Future<bool> signIn({required String email, required String password}) async {
    errorMessage = '';
    notifyListeners();

    final cleanedEmail = email.trim();
    final cleanedPassword = password.trim();

    if (cleanedEmail.isEmpty) {
      errorMessage = 'Please enter your email address.';
      notifyListeners();
      return false;
    }

    if (cleanedPassword.isEmpty) {
      errorMessage = 'Please enter your password.';
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      await authService.SignInWithEmailAndPassword(
        Email: cleanedEmail,
        Password: cleanedPassword,
      );

      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        errorMessage = 'Email or password is incorrect.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email address.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'This account has been disabled.';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many login attempts. Please try again later.';
      } else {
        errorMessage = 'Login failed. Please try again.';
      }

      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = 'Login failed. Please try again.';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
