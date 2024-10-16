import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.onSaved,
    this.inputFormatters,
    this.onChanged,
    this.focusNode,
  });

  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Color color = Colors.grey;
  bool foucsed = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        foucsed = focus;
        if (color != Colors.red) {
          color = focus ? Colors.white : Colors.grey;
          setState(() {});
        }
      },
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            color = Colors.red;
            setState(() {});
            return "Field is required";
          } else if (foucsed) {
            color = Colors.white;
            setState(() {});
          }
          return null;
        },
        focusNode: widget.focusNode,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        cursorOpacityAnimates: true,
        controller: widget.controller,
        cursorColor: color,
        style: const TextStyle(color: Colors.white),
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          filled: true,
          fillColor: Colors.grey.withOpacity(.2),
          border: outlineInputBorder(),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          errorBorder: outlineInputBorder(),
          focusedErrorBorder: outlineInputBorder(),
          disabledBorder: outlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(width: 0, color: Colors.transparent),
    );
  }
}
