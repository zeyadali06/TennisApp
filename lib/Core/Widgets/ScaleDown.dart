import 'package:flutter/material.dart';

class ScaleDown extends StatelessWidget {
  const ScaleDown({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: child,
      ),
    );
  }
}
