import 'package:cashbuddy_mobile/constants/colors.dart';
import 'package:flutter/material.dart';

typedef Pressed = void Function();

class Button extends StatelessWidget {
  final double borderRadius;
  final double height;
  final int backgroundColor;
  final int textColor;
  final Pressed onPressed;
  final Widget? icon;
  final String label;

  const Button({
    super.key,
    required this.onPressed,
    this.backgroundColor = white,
    this.textColor = black,
    this.height = 50,
    this.borderRadius = 9999,
    this.icon,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Color(backgroundColor),
          foregroundColor: Color(textColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        child: Stack(
          children: renderIcon(),
        ),
      ),
    );
  }

  List<Widget> renderIcon() {
    List<Widget> widgets = [];
    final iconWidget = icon;

    if (iconWidget != null) {
      widgets.add(
        Align(
          alignment: Alignment.centerLeft,
          child: iconWidget,
        ),
      );
    }

    widgets.add(
      Align(
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
    return widgets;
  }
}
