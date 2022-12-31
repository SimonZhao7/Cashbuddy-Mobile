import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String id;
  final bool isEmailVerified;

  AuthUser(this.id, this.isEmailVerified);
  
  factory AuthUser.fromUser(User user) {
    return AuthUser(user.uid, user.emailVerified);
  }
}