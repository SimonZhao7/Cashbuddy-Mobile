// Firebase
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
// Constants
import 'package:cashbuddy_mobile/services/transaction/fields.dart';

class Transaction {
  final String id;
  final String userId;
  final String categoryId;
  final String title;
  final String details;
  final double amount;
  final DateTime dateTime;

  const Transaction({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.details,
    required this.amount,
    required this.dateTime,
  });

  factory Transaction.fromFirebase(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final id = snapshot.id;
    final data = snapshot.data();
    final Timestamp timestamp = data[dateTimeField];

    return Transaction(
      id: id,
      userId: data[userIdField],
      categoryId: data[categoryIdField],
      title: data[titleField],
      details: data[detailsField],
      amount: data[amountField],
      dateTime: timestamp.toDate(),
    );
  }
}
