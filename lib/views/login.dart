import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Widgets
import '../widgets/input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _username;
  late TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(darkGreen),
      body: Container(
        padding: const EdgeInsets.all(40),
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
              controller: _username,
              label: 'Username',
            ),
            const Gap(20),
            Input(
              controller: _password,
              password: true,
              label: 'Password',
            ),
            const Gap(20),
            Button(
              onPressed: () {},
              backgroundColor: lightGreen,
              textColor: white,
              label: 'Login',
            ),
            const Gap(20),
            Button(
              onPressed: () {},
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
