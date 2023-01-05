// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';
// Routes
import 'package:cashbuddy_mobile/constants/routes.dart';
// Snackbars
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
// Widgets
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:cashbuddy_mobile/widgets/input.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Util
import 'package:gap/gap.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(darkGreen),
      body: Container(
          padding: const EdgeInsets.all(40),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register an account',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(white),
                    ),
                  ),
                  const Gap(40),
                  Input(
                    controller: _email,
                    label: 'Enter your email...',
                  ),
                  const Gap(20),
                  Input(
                    controller: _password,
                    label: 'Enter a strong password...',
                    password: true,
                  ),
                  const Gap(20),
                  Input(
                    controller: _confirmPassword,
                    label: 'Retype your password...',
                    password: true,
                  ),
                  const Gap(20),
                  Button(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      final confirmPassword = _confirmPassword.text;
                      final navigator = Navigator.of(context);

                      if (password == '') {
                        return showErrorSnackBar(
                          context: context,
                          text: 'No password provided',
                        );
                      }

                      if (confirmPassword == '') {
                        return showErrorSnackBar(
                          context: context,
                          text: 'No password confirmation provided',
                        );
                      }

                      if (password != confirmPassword) {
                        return showErrorSnackBar(
                          context: context,
                          text: 'Passwords do not match',
                        );
                      }

                      try {
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        final user = userCredential.user!;
                        await user.sendEmailVerification();

                        navigator.pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'missing-email') {
                          showErrorSnackBar(
                            context: context,
                            text: 'No email provided',
                          );
                        } else if (e.code == 'invalid-email') {
                          showErrorSnackBar(
                            context: context,
                            text: 'The provided email is invalid',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showErrorSnackBar(
                            context: context,
                            text: 'The provided email is already in use',
                          );
                        } else if (e.code == 'weak-password') {
                          showErrorSnackBar(
                            context: context,
                            text: 'The provided password is too weak',
                          );
                        } else {
                          showErrorSnackBar(
                            context: context,
                            text: 'Something went wrong',
                          );
                        }
                      }
                    },
                    label: 'Register',
                    backgroundColor: lightGreen,
                    textColor: white,
                  ),
                  const Gap(20),
                  Button(
                    onPressed: () {},
                    label: 'Sign up with Google',
                    icon: Image.asset('assets/images/google_icon.png'),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      loginRoute,
                      (route) => false,
                    );
                  },
                  backgroundColor: const Color(lightGreen),
                  child: const Icon(Icons.arrow_back),
                ),
              )
            ],
          )),
    );
  }
}
