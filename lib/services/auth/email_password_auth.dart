import 'package:cashbuddy_mobile/exceptions/auth_exceptions.dart';
import 'package:cashbuddy_mobile/services/auth/auth_provider.dart';
import 'package:cashbuddy_mobile/services/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailPasswordProvider extends AuthProvider {
  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      return AuthUser.fromUser(user);
    } catch (e) {
      throw GenericAuthException();
    }
  }
  
  @override
  Future<AuthUser> login({required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user!;
      return AuthUser.fromUser(user);
    } catch (e) {
      throw GenericAuthException();
    }
  }
  
  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
