import 'package:flutter/material.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/AuthOptionsView/Widgets/AuthOptionsViewBody.dart';

class AuthOptionsView extends StatelessWidget {
  const AuthOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthOptionsViewBody(),
    );
  }
}
