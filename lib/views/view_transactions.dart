import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
// Services
import 'package:cashbuddy_mobile/services/auth/auth_service.dart';
// Constants
import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:cashbuddy_mobile/constants/routes.dart';
// Util
import 'package:decimal/decimal.dart';
import 'package:money2/money2.dart';

class ViewTransactions extends StatefulWidget {
  const ViewTransactions({super.key});

  @override
  State<ViewTransactions> createState() => _ViewTransactionsState();
}

class _ViewTransactionsState extends State<ViewTransactions> {
  @override
  Widget build(BuildContext context) {
    final user = AuthService.email().currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('transactions')
          .where('user_id', isEqualTo: user.id)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            final data = snapshot.data!;
            final transactions = data.docs;
            return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  final transactionId = transactions[index].id;
                  final transaction = transactions[index].data();
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    title: Text(
                      transaction['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    tileColor: const Color(white),
                    subtitle: Text(
                      transaction['details'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      Money.fromDecimal(
                              Decimal.parse(
                                transaction['amount'].toString(),
                              ),
                              code: 'USD')
                          .toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(darkGreen),
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        createOrUpdateTransactionRoute,
                        arguments: {...transaction, 'id': transactionId},
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Gap(20),
                itemCount: transactions.length);
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
