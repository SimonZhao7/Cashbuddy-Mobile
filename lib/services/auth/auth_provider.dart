import 'package:firebase_auth/firebase_auth.dart';
import '../../exceptions/auth_exceptions.dart';
import 'auth_user.dart';

abstract class AuthProvider {  
  Future<AuthUser> register({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  AuthUser get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw UserNotFoundAuthException();
    }
    return AuthUser.fromUser(user);
  }

  Future<void> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        throw TooManyRequestsException();
      }
    }
   
  }
}
