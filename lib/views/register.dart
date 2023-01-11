// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';
// Routes
import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:cashbuddy_mobile/exceptions/auth_exceptions.dart';
import 'package:cashbuddy_mobile/services/auth/auth_service.dart';
// Snackbars
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
// Widgets
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:cashbuddy_mobile/widgets/input.dart';
// Firebase
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
          padding: const EdgeInsets.all(30),
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
                    type: TextInputType.emailAddress,
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

                      try {
                        await AuthService.email().register(
                          email: email,
                          password: password,
                          confirmPassword: confirmPassword,
                        );

                        await AuthService.email().sendEmailVerification();

                        navigator.pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      } catch (e) {
                        if (e is MissingEmailException) {
                          showErrorSnackBar(
                            context: context,
                            text: 'No email provided',
                          );
                        } else if (e is InvalidEmailAuthException) {
                          showErrorSnackBar(
                            context: context,
                            text: 'The provided email is invalid',
                          );
                        } else if (e is EmailAlreadyExistsAuthException) {
                          showErrorSnackBar(
                            context: context,
                            text: 'The provided email is already in use',
                          );
                        } else if (e is WeakPasswordAuthException) {
                          showErrorSnackBar(
                            context: context,
                            text: 'The provided password is too weak',
                          );
                        } else if (e is NoPasswordProvidedAuthException) {
                          return showErrorSnackBar(
                            context: context,
                            text: 'No password provided',
                          );
                        } else if (e
                            is NoConfirmPasswordProvidedAuthException) {
                          return showErrorSnackBar(
                            context: context,
                            text: 'No password confirmation provided',
                          );
                        } else if (e is PasswordsDontMatchAuthException) {
                          return showErrorSnackBar(
                            context: context,
                            text: 'Passwords do not match',
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
