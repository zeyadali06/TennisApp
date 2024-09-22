import 'package:flutter/material.dart';

class AuthViewHeader extends StatelessWidget {
  const AuthViewHeader({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            subTitle,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
