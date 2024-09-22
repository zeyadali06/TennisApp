import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    this.fontSize = 22,
    this.backgroundColor = const Color(0xff014bb4),
    this.height = 50,
    this.onPressed,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w600,
  });

  final String title;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  double height;
  FontWeight fontWeight;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed ?? () {},
      height: height,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
