import 'package:cashbuddy_mobile/services/auth/auth_provider.dart';
import 'package:cashbuddy_mobile/services/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleProvider extends AuthProvider {
  @override
  Future<AuthUser> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> register({required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}