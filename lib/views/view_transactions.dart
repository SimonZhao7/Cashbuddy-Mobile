import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Services
import '../services/transaction/transaction.dart';
import '../services/transaction/transaction_service.dart';
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
  late TransactionService _transactionService;
  late Stream<List<Transaction>> _transactions;

  @override
  void initState() {
    _transactionService = TransactionService();
    _transactions = _transactionService.transactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _transactions,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            final transactions = snapshot.data!;
            return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    title: Text(
                      transaction.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    tileColor: const Color(white),
                    subtitle: Text(
                      transaction.details,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      Money.fromDecimal(
                              Decimal.parse(
                                transaction.amount.toString(),
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
                        arguments: transaction,
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
