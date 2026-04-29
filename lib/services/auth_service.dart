import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static bool _DidJustRegister = false;

  User? GetCurrentUser() {
    return _auth.currentUser;
  }

  Stream<User?> GetAuthStateChanges() {
    return _auth.userChanges();
  }

  bool ConsumeDidJustRegister() {
    final bool Result = _DidJustRegister;
    _DidJustRegister = false;
    return Result;
  }

  Future<UserCredential> SignUpWithEmailAndPassword({
    required String Email,
    required String Password,
    required String FullName,
  }) async {
    final UserCredential Credential = await _auth
        .createUserWithEmailAndPassword(email: Email, password: Password);

    await Credential.user?.updateDisplayName(FullName);
    await Credential.user?.reload();

    _DidJustRegister = true;
    return Credential;
  }

  Future<UserCredential> SignInWithEmailAndPassword({
    required String Email,
    required String Password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: Email,
      password: Password,
    );
  }

  Future<void> SignOut() async {
    _DidJustRegister = false;
    await _auth.signOut();
  }
}
