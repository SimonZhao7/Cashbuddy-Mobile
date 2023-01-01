import 'package:flutter/material.dart';
// Views
import './views/login.dart';
// Constants
import './constants/colors.dart';
import './constants/routes.dart';

void main() {
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
    },
  ));
}
