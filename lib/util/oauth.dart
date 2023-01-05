import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

Future<UserCredential> signInWithGoogle() async {
  final account = await googleSignIn.signIn();
  final authCredential = await account?.authentication;
  final googleAuthCredential = GoogleAuthProvider.credential(
    idToken: authCredential?.idToken,
    accessToken: authCredential?.accessToken,
  );
  final userCredential = await FirebaseAuth.instance.signInWithCredential(
    googleAuthCredential,
  );
  return userCredential;
}
