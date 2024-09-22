import 'package:flutter/material.dart';

class CustomGradiantContainer extends StatelessWidget {
  const CustomGradiantContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff051642),
            Color(0xff000219),
          ],
        ),
      ),
      child: child,
    );
  }
}
