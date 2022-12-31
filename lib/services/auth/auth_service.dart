import 'package:cashbuddy_mobile/services/auth/email_password_auth.dart';
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
  }) =>
      provider.register(
        email: email,
        password: password,
      );

  Future<void> logout() => provider.logout();
}
