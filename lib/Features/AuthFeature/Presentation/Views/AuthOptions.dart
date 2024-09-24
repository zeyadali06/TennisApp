import 'package:flutter/material.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/Widgets/AuthOptionsBody.dart';

class AuthOptions extends StatelessWidget {
  const AuthOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthOptionsBody(),
    );
  }
}
