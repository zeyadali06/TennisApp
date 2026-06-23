import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomObsecureTextFormField extends StatefulWidget {
  const CustomObsecureTextFormField({
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
  State<CustomObsecureTextFormField> createState() =>
      _CustomObsecureTextFormFieldState();
}

class _CustomObsecureTextFormFieldState
    extends State<CustomObsecureTextFormField> {
  Color color = Colors.grey;
  bool foucsed = false;
  bool isObscured = true;

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
        obscureText: isObscured,
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
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        cursorOpacityAnimates: true,
        controller: widget.controller,
        cursorColor: color,
        style: const TextStyle(color: Colors.white),
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: Colors.grey.withValues(alpha: .2),
          border: outlineInputBorder(),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          errorBorder: outlineInputBorder(),
          focusedErrorBorder: outlineInputBorder(),
          disabledBorder: outlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isObscured = !isObscured;
              });
            },
            icon: Icon(
              isObscured ? Icons.visibility_off : Icons.visibility,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      borderSide: BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    );
  }
}
