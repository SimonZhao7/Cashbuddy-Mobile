import 'package:flutter/material.dart';
// Constants
import '../constants/routes.dart';
import 'package:cashbuddy_mobile/constants/colors.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
// Widgets
import 'package:cashbuddy_mobile/widgets/button.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Button(
        onPressed: () async {
          final navigator = Navigator.of(context);
          await FirebaseAuth.instance.signOut();
          navigator.pushNamedAndRemoveUntil(loginRoute, (route) => false);
        },
        label: 'Logout',
        backgroundColor: Colors.red.shade500.value,
        textColor: white,
        borderRadius: 5,
      ),
    );
  }
}
