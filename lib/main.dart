import 'package:cashbuddy_mobile/views/home.dart';
import 'package:cashbuddy_mobile/views/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// Views
import './views/login.dart';
// Constants
import './constants/colors.dart';
import './constants/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(darkGreen),
      ),
    ),
    initialRoute: loginRoute,
    routes: {
      loginRoute: (context) => const Login(),
      registerRoute: (context) => const Register(),
      homeRoute: (context) => const Home(),
    },
  ));
}
