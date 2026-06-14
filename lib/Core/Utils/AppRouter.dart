import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tennis_app/CustomNavigationBar.dart';
import 'package:tennis_app/Core/Utils/DependencyInjection.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/GetPredictionUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/HomeView.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/LoginView/LoginView.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/AnotherDayWeatherUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/CurrentDayWeatherUseCase.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/UseCases/SearchForLocationsUseCase.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsManagerView/ShowLocationOnMapView.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsView/MapView.dart';
import 'package:tennis_app/Features/SplashFeature/Presentation/Controllers/cubit/splash_view_cubit.dart';
import 'package:tennis_app/Features/SplashFeature/Presentation/Views/SplashView/SplashView.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/RegisterView/RegisterView.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/LoginCubit/login_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/AuthOptionsView/AuthOptionsView.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsView/LocationsView.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Controllers/HomeViewCubit/home_view_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/RegisterCubit/register_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/ForgetPassowrdView/ForgetPasswordView.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsManagerView/LocationsManagerView.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/AddLocationsCubit/add_locations_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/ForgetPasswordCubit/forget_password_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/LocationManagerCubit/location_manager_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

abstract class AppRouter {
  static final Widget loginView = BlocProvider(
    create: (context) => LoginCubit(getit.get<AuthRepo>()),
    child: const LoginView(),
  );

  static final Widget forgetPasswordView = BlocProvider(
    create: (context) =>
        ForgetPasswordCubit(getit.get<ForgetPasswordUseCase>()),
    child: const ForgetPasswordView(),
  );

  static final Widget registerView = BlocProvider(
    create: (context) => RegisterCubit(getit.get<AuthRepo>()),
    child: const RegisterView(),
  );

  static final Widget navigationBar = MultiBlocProvider(
    providers: [
      BlocProvider<SearchForLoactionCubit>(
        create: (context) =>
            SearchForLoactionCubit(getit.get<SearchForLocationsUseCase>()),
      ),
      BlocProvider<AddLocationsCubit>(
        create: (context) =>
            AddLocationsCubit(getit.get<LocationManagerRepo>()),
      ),
      BlocProvider<LocationManagerCubit>(
        create: (context) =>
            LocationManagerCubit(getit.get<LocationManagerRepo>()),
      ),
      BlocProvider<HomeViewCubit>(
        create: (context) => HomeViewCubit(
          getit.get<CurrentDayWeatherUseCase>(),
          getit.get<AnotherDayWeatherUseCase>(),
          getit.get<LocationManagerRepo>(),
          getit.get<GetPredictionUseCase>(),
        )..getCurrentWeather(),
      ),
    ],
    child: const CustomNavigationBar(),
  );

  static final Widget splashView = BlocProvider(
    create: (context) =>
        SplashViewCubit(authRepo: getit.get<AuthRepo>())..autoLogin(),
    child: const SplashView(),
  );

  static const Widget locationsManagerView = LocationsManagerView();
  static const Widget locationsView = LocationsView();
  static const Widget authOptions = AuthOptionsView();
  static const Widget homeView = HomeView();
  static const Widget mapView = MapView();

  // ignore: prefer_function_declarations_over_variables
  static final Widget Function(LatLng coordinates) showLocationOnMapView =
      (coordinates) => ShowLocationOnMapView(coordinates: coordinates);

  static MaterialPageRoute<T> getRoute<T>(BuildContext context, Widget toView) {
    return MaterialPageRoute(builder: (context) {
      return toView;
    });
  }
}
