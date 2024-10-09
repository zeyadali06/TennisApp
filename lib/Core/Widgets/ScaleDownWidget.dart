import 'package:flutter/widgets.dart';

class FittedWidget extends StatelessWidget {
  const FittedWidget({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: child,
    );
  }
}
