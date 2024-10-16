import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/Authentication.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/AIModelServices.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/WeatherApiServices.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/GetPredictionUseCase.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/LocationServices.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Data/RepoImplementation/AIModelRepoImpl.dart';
import 'package:tennis_app/Features/HomeFeature/Data/RepoImplementation/WeatherRepoImpl.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/AnotherDayWeatherUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/CurrentDayWeatherUseCase.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationRepoImpl.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationManagerRepoImpl.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/UseCases/GetMyLocationUseCase.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/UseCases/SearchForLocationsUseCase.dart';

GetIt getit = GetIt.instance;

void setup() {
  getit.registerSingleton<Dio>(Dio());

  getit.registerSingleton<SignIn>(SignIn());

  getit.registerSingleton<Register>(Register());

  getit.registerSingleton<AccountData>(AccountData());

  getit.registerSingleton<Firestore>(Firestore());

  getit.registerSingleton<WeatherApiServices>(
    WeatherApiServices(dio: getit.get<Dio>()),
  );

  getit.registerSingleton<LocationServices>(
    LocationServices(dio: getit.get<Dio>()),
  );

  getit.registerSingleton<LocationManagerRepoImpl>(
    LocationManagerRepoImpl(firestore: getit.get<Firestore>()),
  );

  getit.registerSingleton<LocationRepoImpl>(
    LocationRepoImpl(locationServices: getit.get<LocationServices>()),
  );

  getit.registerSingleton<AIModelServices>(
    AIModelServices(dio: getit.get<Dio>()),
  );

  getit.registerSingleton<AIModelRepoImpl>(
    AIModelRepoImpl(aiModelServices: getit.get<AIModelServices>()),
  );

  getit.registerSingleton<WeatherRepoImpl>(
    WeatherRepoImpl(
      weatherApiServices: getit.get<WeatherApiServices>(),
      locationManagerRepo: getit.get<LocationManagerRepoImpl>(),
    ),
  );

  getit.registerSingleton<GetPredictionUseCase>(
    GetPredictionUseCase(
      aiModelRepo: getit.get<AIModelRepoImpl>(),
      weatherRepo: getit.get<WeatherRepoImpl>(),
    ),
  );

  getit.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      locationManagerRepo: getit.get<LocationManagerRepoImpl>(),
      accountData: getit.get<AccountData>(),
      firestore: getit.get<Firestore>(),
      register: getit.get<Register>(),
      signIn: getit.get<SignIn>(),
    ),
  );

  getit.registerSingleton<ForgetPasswordUseCase>(
    ForgetPasswordUseCase(
      authRepo: getit.get<AuthRepoImpl>(),
      accountData: getit.get<AccountData>(),
    ),
  );

  getit.registerSingleton<CurrentDayWeatherUseCase>(
    CurrentDayWeatherUseCase(
      weatherRepo: getit.get<WeatherRepoImpl>(),
    ),
  );

  getit.registerSingleton<AnotherDayWeatherUseCase>(
    AnotherDayWeatherUseCase(
      weatherRepo: getit.get<WeatherRepoImpl>(),
    ),
  );

  getit.registerSingleton<GetMyLocationUseCase>(
    GetMyLocationUseCase(
      locationRepo: getit.get<LocationRepoImpl>(),
    ),
  );

  getit.registerSingleton<SearchForLocationsUseCase>(
    SearchForLocationsUseCase(
      locationRepo: getit.get<LocationRepoImpl>(),
    ),
  );
}
