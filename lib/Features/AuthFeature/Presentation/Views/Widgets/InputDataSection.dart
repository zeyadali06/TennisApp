import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_app/Core/Widgets/CustomTextFormField.dart';
import 'package:tennis_app/Core/Widgets/ScaleDown.dart';

class InputDataSection extends StatelessWidget {
  const InputDataSection({
    super.key,
    required this.title,
    this.controller,
    this.inputFormatters,
    this.onSaved,
    this.onChanged,
    this.focusNode,
  });

  final String title;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;

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
        CustomTextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          onSaved: onSaved,
          onChanged: onChanged,
          focusNode: focusNode,
        ),
      ],
    );
  }
}
