import 'package:bulkpal_mobile/features/authentication/views/login_page.dart';
import 'package:bulkpal_mobile/features/authentication/view_models/login_view_model.dart';
import 'package:bulkpal_mobile/services/auth_service.dart';
import 'package:bulkpal_mobile/features/bottom_navigation_bar/view_models/navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService Auth = AuthService();

    return StreamBuilder<User?>(
      stream: Auth.GetAuthStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return NavigationController();
        }

        return ChangeNotifierProvider(
          create: (_) => LoginViewModel(authService: AuthService()),
          child: const LoginView(),
        );
      },
    );
  }
}
