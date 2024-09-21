import 'package:flutter/material.dart';
import 'package:weather_app/Features/SplashFeature/Presentation/Views/Widgets/SplashViewBody.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
