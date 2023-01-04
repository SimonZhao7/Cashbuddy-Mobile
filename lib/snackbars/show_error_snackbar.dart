import 'package:flutter/material.dart';
import '../constants/colors.dart';

void showErrorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      backgroundColor: Colors.red[500],
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      duration: const Duration(milliseconds: 2500),
      action: SnackBarAction(
        label: 'Ok',
        textColor: const Color(white),
        onPressed: () {},
      ),
    ),
  );
}
