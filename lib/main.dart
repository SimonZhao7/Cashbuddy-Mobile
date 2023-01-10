import 'package:cashbuddy_mobile/views/create_category.dart';
import 'package:cashbuddy_mobile/views/home.dart';
import 'package:cashbuddy_mobile/views/register.dart';
import 'package:cashbuddy_mobile/views/setup_budget.dart';
import 'package:cashbuddy_mobile/views/view_categories.dart';
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
      setBudgetRoute: (context) => const SetupBudget(),
      viewCategoriesRoute: (context) => const ViewCategories(),
      createCategoriesRoute: (context) => const CreateCategory(),
    },
  ));
}
