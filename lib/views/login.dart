import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/exceptions/auth_exceptions.dart';
import 'package:cashbuddy_mobile/services/auth/auth_service.dart';
import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
// Widgets
import 'package:cashbuddy_mobile/widgets/input.dart';
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Util
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _email;
  late TextEditingController _password;
  final emailAuth = AuthService.email();
  final googleAuth = AuthService.google();

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

  void handleNavigation(AuthUser user) async {
    final navigator = Navigator.of(context);
    final db = FirebaseFirestore.instance;

    if (user.isEmailVerified) {
      final userData = await db
          .collection('users')
          .where(
            'user_id',
            isEqualTo: user.id,
          )
          .get();

      if (userData.docs.isEmpty) {
        navigator.pushNamedAndRemoveUntil(
          setBudgetRoute,
          (route) => false,
        );
      } else {
        navigator.pushNamedAndRemoveUntil(
          homeRoute,
          (route) => false,
        );
      }
    } else {
      showErrorSnackBar(
        context: context,
        text: "Email is not verified",
        action: SnackBarAction(
          label: 'Resend Verification',
          onPressed: () async {
            try {
              await emailAuth.sendEmailVerification();
            } catch (e) {
              if (e is TooManyRequestsException) {
                showErrorSnackBar(
                  context: context,
                  text: 'Please wait before requesting another email.',
                );
              }
            }
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
              type: TextInputType.emailAddress,
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
                  final user = await emailAuth.login(
                    email: email,
                    password: password,
                  );
                  handleNavigation(user);
                } catch (e) {
                  if (e is InvalidEmailAuthException ||
                      e is UserNotFoundAuthException ||
                      e is WrongPasswordAuthException) {
                    return showErrorSnackBar(
                      context: context,
                      text: 'Invalid login credentials',
                    );
                  } else {
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
                  final user = await googleAuth.login(
                    email: '',
                    password: '',
                  );
                  handleNavigation(user);
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
