import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Utils/DependencyInjection.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/LoginView.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/AuthOptions.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/RegisterView.dart';
import 'package:tennis_app/Features/SplashFeature/Presentation/Views/SplashView.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/LoginCubit/login_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/RegisterCubit/register_cubit.dart';

abstract class AppRouter {
  static const Widget splashView = SplashView();
  static Widget loginView = BlocProvider(
    create: (context) => LoginCubit(getit.get<AuthRepoImpl>()),
    child: const LoginView(),
  );
  static Widget registerView = BlocProvider(
    create: (context) => RegisterCubit(getit.get<AuthRepoImpl>()),
    child: const RegisterView(),
  );
  static const Widget authOptions = AuthOptions();
  static const Widget homeView = HomeView();

  static MaterialPageRoute goTo(BuildContext context, Widget toView) {
    return MaterialPageRoute(builder: (context) {
      return toView;
    });
  }
}
