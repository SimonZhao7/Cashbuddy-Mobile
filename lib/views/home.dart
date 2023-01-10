import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:cashbuddy_mobile/views/view_categories.dart';
import 'package:flutter/material.dart';
// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';
// Views
import 'package:cashbuddy_mobile/views/account_settings.dart';
import 'package:cashbuddy_mobile/views/home_content.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _routeIndex = 0;
  static const List<String> titles = [
    'Home',
    'Categories',
    'Transactions',
    'Account'
  ];

  static const List<Widget> views = [
    HomeContent(),
    ViewCategories(),
    HomeContent(),
    AccountSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget?> floatingActionButtons = [
      null,
      FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateCategoryRoute);
        },
        backgroundColor: const Color(darkGreen),
        child: const Icon(Icons.add),
      ),
      null,
      null
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: Text(titles[_routeIndex])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(white),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_rounded),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _routeIndex,
        onTap: (int index) {
          setState(() {
            _routeIndex = index;
          });
        },
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color(darkGreen),
      ),
      body: views[_routeIndex],
      floatingActionButton: floatingActionButtons[_routeIndex],
    );
  }
}
