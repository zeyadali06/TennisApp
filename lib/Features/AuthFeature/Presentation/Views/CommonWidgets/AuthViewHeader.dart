import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';

class AuthViewHeader extends StatelessWidget {
  const AuthViewHeader({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedWidget(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, height: 1),
          ),
        ),
        FittedWidget(
          child: Text(
            subTitle,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
