import 'package:firebase_auth/firebase_auth.dart';
import 'auth_user.dart';

abstract class AuthProvider {
  Future<AuthUser> register({
    required String email,
    required String password,
  });

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  AuthUser? currentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return AuthUser.fromUser(user);
  }
}
