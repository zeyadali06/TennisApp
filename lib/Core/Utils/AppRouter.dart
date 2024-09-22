import 'package:flutter/material.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/LoginView.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/RegisterView.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/AuthOptions.dart';
import 'package:weather_app/Features/SplashFeature/Presentation/Views/SplashView.dart';

abstract class AppRouter {
  static const Widget splashView = SplashView();
  static const Widget loginView = LoginView();
  static const Widget registerView = RegisterView();
  static const Widget authOptions = AuthOptions();

  static MaterialPageRoute goTo(BuildContext context, Widget toView) {
    return MaterialPageRoute(builder: (context) {
      return toView;
    });
  }
}
