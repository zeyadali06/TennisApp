import 'package:flutter/material.dart';
import 'package:weather_app/Core/Widgets/CustomTextFormField.dart';
import 'package:weather_app/Core/Widgets/ScaleDown.dart';

class InputDataSection extends StatelessWidget {
  const InputDataSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            ScaleDown(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const CustomTextFormField(),
      ],
    );
  }
}
