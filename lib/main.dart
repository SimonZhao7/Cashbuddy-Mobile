import 'package:cashbuddy_mobile/services/auth/auth_service.dart';
import 'package:cashbuddy_mobile/views/create_category.dart';
import 'package:cashbuddy_mobile/views/create_transaction.dart';
import 'package:cashbuddy_mobile/views/home.dart';
import 'package:cashbuddy_mobile/views/register.dart';
import 'package:cashbuddy_mobile/views/setup_budget.dart';
import 'package:cashbuddy_mobile/views/view_categories.dart';
import 'package:cashbuddy_mobile/views/view_transactions.dart';
import 'package:flutter/material.dart';
// Views
import './views/login.dart';
// Constants
import './constants/colors.dart';
import './constants/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.initialize();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(darkGreen),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(darkGreen),
        )),
    initialRoute: loginRoute,
    routes: {
      loginRoute: (context) => const Login(),
      registerRoute: (context) => const Register(),
      homeRoute: (context) => const Home(),
      setBudgetRoute: (context) => const SetupBudget(),
      viewCategoriesRoute: (context) => const ViewCategories(),
      createOrUpdateCategoryRoute: (context) => const CreateCategory(),
      createOrUpdateTransactionRoute: (context) => const CreateTransaction(),
      viewTransactionsRoute: (context) => const ViewTransactions(),
    },
  ));
}
