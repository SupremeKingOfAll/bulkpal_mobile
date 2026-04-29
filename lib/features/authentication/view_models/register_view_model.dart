import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bulkpal_mobile/services/auth_service.dart';

class RegisterViewModel with ChangeNotifier {
  RegisterViewModel({required this.authService});

  final AuthService authService;

  bool isLoading = false;
  String errorMessage = '';

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required bool hasAcceptedTerms,
  }) async {
    errorMessage = '';
    notifyListeners();

    final cleanedFullName = fullName.trim();
    final cleanedEmail = email.trim();
    final cleanedPassword = password.trim();
    final cleanedConfirmPassword = confirmPassword.trim();

    if (cleanedFullName.isEmpty) {
      errorMessage = 'Please enter your full name.';
      notifyListeners();
      return false;
    }

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

    if (cleanedConfirmPassword.isEmpty) {
      errorMessage = 'Please confirm your password.';
      notifyListeners();
      return false;
    }

    if (cleanedPassword != cleanedConfirmPassword) {
      errorMessage = 'Passwords do not match.';
      notifyListeners();
      return false;
    }

    if (!hasAcceptedTerms) {
      errorMessage = 'You must agree to the Terms and Privacy Policy.';
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      await authService.SignUpWithEmailAndPassword(
        Email: cleanedEmail,
        Password: cleanedPassword,
        FullName: cleanedFullName,
      );

      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email address is already registered.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email address.';
      } else if (e.code == 'weak-password') {
        errorMessage =
            'Password is too weak. Please use at least 6 characters.';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'Email and password registration is not enabled.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Network error. Please check your internet connection.';
      } else {
        errorMessage = 'Registration failed. Please try again.';
      }

      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = 'Registration failed. Please try again.';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
