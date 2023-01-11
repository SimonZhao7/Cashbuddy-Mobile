import 'package:cashbuddy_mobile/exceptions/auth_exceptions.dart';
import 'package:cashbuddy_mobile/services/auth/auth_provider.dart';
import 'package:cashbuddy_mobile/services/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailPasswordProvider extends AuthProvider {
  @override
  Future<AuthUser> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password == '') {
      throw NoPasswordProvidedAuthException();
    }

    if (confirmPassword == '') {
      throw NoConfirmPasswordProvidedAuthException();
    }

    if (password != confirmPassword) {
      throw PasswordsDontMatchAuthException();
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      return AuthUser.fromUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'missing-email') {
        throw MissingEmailException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistsAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      }
      throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user!;
      return AuthUser.fromUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
      } else if (e.code == 'user-disabled') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      }
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
