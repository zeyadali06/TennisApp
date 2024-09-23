import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Controllers/LoginCubit/login_cubit.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Controllers/RegisterCubit/register_cubit.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/LoginView.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/RegisterView.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/AuthOptions.dart';
import 'package:weather_app/Features/SplashFeature/Presentation/Views/SplashView.dart';

abstract class AppRouter {
  static const Widget splashView = SplashView();
  static Widget loginView = BlocProvider(
    create: (context) => LoginCubit(AuthRepoImpl()),
    child: const LoginView(),
  );
  static Widget registerView = BlocProvider(
    create: (context) => RegisterCubit(AuthRepoImpl()),
    child: const RegisterView(),
  );
  static const Widget authOptions = AuthOptions();

  static MaterialPageRoute goTo(BuildContext context, Widget toView) {
    return MaterialPageRoute(builder: (context) {
      return toView;
    });
  }
}
