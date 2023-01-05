import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/constants/routes.dart';
import 'package:cashbuddy_mobile/snackbars/show_error_snackbar.dart';
import 'package:cashbuddy_mobile/widgets/button.dart';
import 'package:cashbuddy_mobile/widgets/input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SetupBudget extends StatefulWidget {
  const SetupBudget({super.key});

  @override
  State<SetupBudget> createState() => _SetupBudgetState();
}

class _SetupBudgetState extends State<SetupBudget> {
  late TextEditingController _budget;

  @override
  void initState() {
    _budget = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _budget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(darkGreen),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 40,
                color: Color(white),
              ),
            ),
            const Gap(20),
            const Text(
              'This must be your first time on this app. Enter your budget below to begin your healthy spending journey!',
              style: TextStyle(
                fontSize: 16,
                color: Color(white),
              ),
            ),
            const Gap(40),
            Input(
              controller: _budget,
              label: 'Budget (e.g. 1000)',
              type: TextInputType.number,
            ),
            const Gap(20),
            Button(
              onPressed: () async {
                final budget = _budget.text;
                final db = FirebaseFirestore.instance;
                final currentUser = FirebaseAuth.instance.currentUser!;
                final navigator = Navigator.of(context);

                if (budget == '') {
                  return showErrorSnackBar(
                    context: context,
                    text: 'No number provided',
                  );
                }

                final convertedBudget = double.parse(budget);

                if (convertedBudget <= 0) {
                  return showErrorSnackBar(
                    context: context,
                    text: 'Please enter a valid number',
                  );
                }

                await db.collection('users').add({
                  'user_id': currentUser.uid,
                  'budget': convertedBudget,
                });
                navigator.pushNamedAndRemoveUntil(homeRoute, (route) => false);
              },
              backgroundColor: lightGreen,
              textColor: white,
              label: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
