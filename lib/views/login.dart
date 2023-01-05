import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/util/oauth.dart';
import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
// Widgets
import 'package:cashbuddy_mobile/widgets/input.dart';
import 'package:cashbuddy_mobile/widgets/button.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
// Util
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void handleNavigation(UserCredential userCredential) {
    final navigator = Navigator.of(context);
    final user = userCredential.user;

    if (user?.emailVerified ?? false) {
      navigator.pushNamedAndRemoveUntil(
        homeRoute,
        (route) => false,
      );
    } else {
      showErrorSnackBar(
        context: context,
        text: "Email is not verified",
        action: SnackBarAction(
          label: 'Resend Verification',
          onPressed: () async {
            await user?.sendEmailVerification();
          },
          textColor: const Color(white),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(darkGreen),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'CashBuddy',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const Gap(60),
            Input(
              controller: _email,
              label: 'Email',
            ),
            const Gap(20),
            Input(
              controller: _password,
              password: true,
              label: 'Password',
            ),
            const Gap(20),
            Button(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  final userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  handleNavigation(userCredential);
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case 'invalid-email':
                    case 'user-disabled':
                    case 'user-not-found':
                    case 'wrong-password':
                      return showErrorSnackBar(
                        context: context,
                        text: 'Invalid login credentials',
                      );
                    default:
                      return showErrorSnackBar(
                        context: context,
                        text: 'Something went wrong',
                      );
                  }
                }
              },
              backgroundColor: lightGreen,
              textColor: white,
              label: 'Login',
            ),
            const Gap(20),
            Button(
              onPressed: () async {
                try {
                  final userCredential = await signInWithGoogle();
                  handleNavigation(userCredential);
                } catch (e) {
                  return showErrorSnackBar(
                    context: context,
                    text: 'Unable to sign in with Google',
                  );
                }
              },
              icon: Image.asset('assets/images/google_icon.png'),
              label: 'Sign in With Google',
            ),
            const Gap(20),
            Button(
              onPressed: () {
                Navigator.of(context).pushNamed(registerRoute);
              },
              label: 'Register for an account',
              icon: const Icon(
                Icons.account_circle,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
