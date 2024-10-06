import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';

class ScaleDown extends StatelessWidget {
  const ScaleDown({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedWidget(
        child: child,
      ),
    );
  }
}
