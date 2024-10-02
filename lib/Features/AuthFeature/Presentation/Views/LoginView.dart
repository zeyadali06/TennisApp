import 'package:flutter/material.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/Widgets/LoginViewBody.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginViewBody(),
    );
  }
}
