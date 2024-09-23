import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, [int seconds = 2]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
    ),
    duration: Duration(seconds: seconds),
    backgroundColor: Colors.blue,
  ));
}
