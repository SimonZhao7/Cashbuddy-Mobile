import 'package:cashbuddy_mobile/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../exceptions/transaction_exceptions.dart';
import '../category/category_service.dart';
import 'fields.dart';

class TransactionService {
  final user = AuthService.email().currentUser;
  final categories = CategoryService();
  final collection = FirebaseFirestore.instance.collection(collectionName);
  static final _shared = TransactionService._sharedInstance();

  TransactionService._sharedInstance();
  factory TransactionService() => _shared;

  Future<void> createTransaction({
    required String? selectedCategory,
    required String title,
    required String details,
    required String amount,
    required DateTime? date,
    required TimeOfDay? time,
  }) async {
    final values = await _validateAndFormat(
      selectedCategory: selectedCategory,
      title: title,
      details: details,
      amount: amount,
      date: date,
      time: time,
    );

    final categoryId = values[0];
    final dateTime = values[1];

    await collection.add({
      userIdField: user.id,
      categoryIdField: categoryId,
      titleField: title,
      detailsField: details,
      amountField: amount,
      dateTimeField: dateTime,
    });
  }

  Future<void> updateCategory({
    required String? selectedCategory,
    required String title,
    required String details,
    required String amount,
    required DateTime? date,
    required TimeOfDay? time,
    required String id,
  }) async {
    final values = await _validateAndFormat(
      selectedCategory: selectedCategory,
      title: title,
      details: details,
      amount: amount,
      date: date,
      time: time,
    );

    final categoryId = values[0];
    final dateTime = values[1];

    await collection.doc(id).update({
      userIdField: user.id,
      categoryIdField: categoryId,
      titleField: title,
      detailsField: details,
      amountField: amount,
      dateTimeField: dateTime,
    });
  }

  Future<List<dynamic>> _validateAndFormat({
    required String? selectedCategory,
    required String title,
    required String details,
    required String amount,
    required DateTime? date,
    required TimeOfDay? time,
  }) async {
    final categoryList = await categories.fetchCategories().first;

    if (selectedCategory == null) {
      throw NoCategorySelectedException();
    }

    if (title.trim().isEmpty) {
      throw NoTitleProvidedException();
    }

    if (amount.trim().isEmpty) {
      throw NoAmountProvidedException();
    }

    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      throw InvalidAmountTypeException();
    }

    if (date == null) {
      throw NoDateSelectedException();
    }

    if (time == null) {
      throw NoTimeSelectedException();
    }

    final categoryId = categoryList
        .firstWhere(
          (category) => category.title == selectedCategory,
        )
        .id;

    final dateTime = date.add(
      Duration(
        hours: time.hour,
        minutes: time.minute,
      ),
    );

    return [categoryId, dateTime];
  }
}
