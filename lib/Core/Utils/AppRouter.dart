import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/CustomNavigationBar.dart';
import 'package:tennis_app/Core/Utils/DependencyInjection.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/HomeView.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/LoginView/LoginView.dart';
import 'package:tennis_app/Features/SplashFeature/Presentation/Views/SplashView/SplashView.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/RegisterView/RegisterView.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/LoginCubit/login_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/AuthOptionsView/AuthOptionsView.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsView/LocationsView.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationManagerRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/RegisterCubit/register_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/ForgetPassowrdView/ForgetPasswordView.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsManagerView/LocationsManagerView.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/AddLocationsCubit/add_locations_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/ForgetPasswordCubit/forget_password_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/GetMyLocationCubit/get_my_location_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/LocationManagerCubit/location_manager_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

abstract class AppRouter {
  static final Widget loginView = BlocProvider(
    create: (context) => LoginCubit(getit.get<AuthRepoImpl>()),
    child: const LoginView(),
  );

  static final Widget forgetPasswordView = BlocProvider(
    create: (context) => ForgetPasswordCubit(getit.get<ForgetPasswordUseCase>()),
    child: const ForgetPasswordView(),
  );

  static final Widget registerView = BlocProvider(
    create: (context) => RegisterCubit(getit.get<AuthRepoImpl>()),
    child: const RegisterView(),
  );

  static final Widget locationsManagerView = BlocProvider(
    create: (context) => LocationManagerCubit(getit.get<LocationManagerRepoImpl>()),
    child: const LocationsManagerView(),
  );

  static final Widget locationsView = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GetMyLocationCubit(getit.get<LocationRepoImpl>()),
      ),
      BlocProvider(
        create: (context) => SearchForLoactionCubit(getit.get<LocationRepoImpl>()),
      ),
      BlocProvider(
        create: (context) => AddLocationsCubit(getit.get<LocationManagerRepoImpl>()),
      ),
    ],
    child: const LocationsView(),
  );

  static const Widget navigationBar = CustomNavigationBar();
  static const Widget splashView = SplashView();
  static const Widget authOptions = AuthOptionsView();
  static const Widget homeView = HomeView();

  static MaterialPageRoute goTo(BuildContext context, Widget toView) {
    return MaterialPageRoute(builder: (context) {
      return toView;
    });
  }
}
