import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final int borderColor;
  final int backgroundColor;
  final int cursorColor;
  final String label;
  final double borderRadius;
  final double borderWidth;
  final bool password;
  final bool autofocus;
  final TextInputType type;

  const Input({
    super.key,
    this.borderColor = darkGreen,
    this.backgroundColor = 0xffffffff,
    this.cursorColor = darkGreen,
    required this.controller,
    this.label = '',
    this.borderRadius = 10,
    this.borderWidth = 2,
    this.password = false,
    this.type = TextInputType.text,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      cursorColor: Color(cursorColor),
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Color(backgroundColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(borderColor), width: borderWidth),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(borderColor), width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
      keyboardType: type,
      obscureText: password,
    );
  }
}
