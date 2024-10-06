import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';

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
    this.verticatPadding = 15.0,
    this.horizontalPadding = 20.0,
  });

  final String title;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  double height;
  FontWeight fontWeight;
  final void Function()? onPressed;
  double verticatPadding;
  double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed ?? () {},
      height: height,
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: verticatPadding, horizontal: horizontalPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: FittedWidget(
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
