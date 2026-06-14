import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key, this.onChanged, required this.initValue});

  final Future<bool> Function(bool value)? onChanged;
  final bool initValue;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool enabled;

  @override
  void initState() {
    enabled = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      onChanged: (value) async {
        if (await (widget.onChanged?.call(value!))!) {
          enabled = value!;
          try {
            setState(() {});
          } catch (_) {}
        }
      },
      value: enabled,
      activeColor: const Color(0xff044abb),
    );
  }
}
