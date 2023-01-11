import 'package:cashbuddy_mobile/services/auth/email_password_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './google_provider.dart';
import 'auth_provider.dart';
import 'auth_user.dart';

class AuthService {
  final AuthProvider provider;

  AuthService(this.provider);
  factory AuthService.email() => AuthService(EmailPasswordProvider());
  factory AuthService.google() => AuthService(GoogleProvider());

  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  Future<AuthUser> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) =>
      provider.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

  Future<void> logout() => provider.logout();

  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  AuthUser get currentUser => provider.currentUser;

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}
