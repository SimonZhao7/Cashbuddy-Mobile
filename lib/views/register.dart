import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:cashbuddy_mobile/widgets/input.dart';
import 'package:flutter/material.dart';
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
                    label: 'Enter your username...',
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
                    onPressed: () {},
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
                        context, loginRoute, (route) => false);
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
