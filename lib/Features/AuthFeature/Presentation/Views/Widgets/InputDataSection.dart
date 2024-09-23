import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/Core/Widgets/CustomTextFormField.dart';
import 'package:weather_app/Core/Widgets/ScaleDown.dart';

class InputDataSection extends StatelessWidget {
  const InputDataSection({super.key, required this.title, this.controller, this.inputFormatters, this.onSaved, this.onChanged});
  final String title;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

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
