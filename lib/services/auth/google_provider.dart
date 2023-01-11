import 'package:cashbuddy_mobile/exceptions/auth_exceptions.dart';
import 'package:cashbuddy_mobile/services/auth/auth_provider.dart';
import 'package:cashbuddy_mobile/services/auth/auth_user.dart';
import '../../util/oauth.dart';

class GoogleProvider extends AuthProvider {
  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await signInWithGoogle();
      final user = userCredential.user!;
      return AuthUser.fromUser(user);
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    throw NoFunctionalityException();
  }
}
