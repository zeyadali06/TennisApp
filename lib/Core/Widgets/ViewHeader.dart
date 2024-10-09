import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';

class ViewHeader extends StatelessWidget {
  const ViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FittedWidget(
          child: Text(
            'Hello',
            style: TextStyle(color: Color(0xff0053bd), fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        FittedWidget(
          child: Text(
            ConstantNames.userModel.fullName.toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
