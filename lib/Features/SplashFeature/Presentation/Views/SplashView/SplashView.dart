import 'package:flutter/material.dart';
import 'package:tennis_app/Features/SplashFeature/Presentation/Views/SplashView/Widgets/SplashViewBody.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
