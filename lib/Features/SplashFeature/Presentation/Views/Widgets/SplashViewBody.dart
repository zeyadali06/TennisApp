import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Core/Utils/AppRouter.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then(
      (value) {
        Navigator.pushReplacement(context, AppRouter.goTo(context, AppRouter.authOptions));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Lottie.asset("assets/images/Animation - 1727014378992.json", repeat: true),
      ),
    );
  }
}
