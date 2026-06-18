import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tennis_app/Core/Utils/Authentication.dart';
import 'package:tennis_app/Core/Utils/LocalDatabaseService.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/AIModelServices.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/WeatherApiServices.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/AIModelRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/WeatherRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/GetPredictionUseCase.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/LocationServices.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Data/RepoImplementation/AIModelRepoImpl.dart';
import 'package:tennis_app/Features/HomeFeature/Data/RepoImplementation/WeatherRepoImpl.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/AnotherDayWeatherUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/CurrentDayWeatherUseCase.dart';
import 'package:tennis_app/Core/Utils/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationRepoImpl.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationManagerRepoImpl.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/UseCases/GetMyLocationUseCase.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/UseCases/SearchForLocationsUseCase.dart';

GetIt getit = GetIt.instance;

void setup() {
  getit.registerSingleton<Dio>(Dio());

  getit.registerSingleton<SignIn>(SignIn());

  getit.registerSingleton<SignOut>(SignOut());

  getit.registerSingleton<Register>(Register());

  getit.registerSingleton<AccountData>(AccountData());

  getit.registerSingleton<Firestore>(Firestore());

  getit.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  getit.registerSingleton<WeatherApiServices>(
    WeatherApiServices(dio: getit.get<Dio>()),
  );

  getit.registerSingleton<LocationServices>(
    LocationServices(dio: getit.get<Dio>()),
  );

  getit.registerSingleton<LocationManagerRepo>(
    LocationManagerRepoImpl(firestore: getit.get<Firestore>()),
  );

  getit.registerSingleton<LocationRepo>(
    LocationRepoImpl(locationServices: getit.get<LocationServices>()),
  );

  getit.registerSingleton<AIModelServices>(
    AIModelServices(dio: getit.get<Dio>()),
  );

  getit.registerSingleton<AIModelRepo>(
    AIModelRepoImpl(aiModelServices: getit.get<AIModelServices>()),
  );

  getit.registerSingleton<LocalDatabaseService>(
    LocalDatabaseService(
      flutterSecureStorage: getit.get<FlutterSecureStorage>(),
    ),
  );

  getit.registerSingleton<WeatherRepo>(
    WeatherRepoImpl(
      weatherApiServices: getit.get<WeatherApiServices>(),
      locationManagerRepo: getit.get<LocationManagerRepo>(),
    ),
  );

  getit.registerSingleton<GetPredictionUseCase>(
    GetPredictionUseCase(
      aiModelRepo: getit.get<AIModelRepo>(),
      weatherRepo: getit.get<WeatherRepo>(),
    ),
  );

  getit.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      locationManagerRepo: getit.get<LocationManagerRepo>(),
      localDatabaseService: getit.get<LocalDatabaseService>(),
      accountData: getit.get<AccountData>(),
      firestore: getit.get<Firestore>(),
      register: getit.get<Register>(),
      signOut: getit.get<SignOut>(),
      signIn: getit.get<SignIn>(),
    ),
  );

  getit.registerSingleton<ForgetPasswordUseCase>(
    ForgetPasswordUseCase(
      authRepo: getit.get<AuthRepo>(),
      accountData: getit.get<AccountData>(),
    ),
  );

  getit.registerSingleton<CurrentDayWeatherUseCase>(
    CurrentDayWeatherUseCase(
      weatherRepo: getit.get<WeatherRepo>(),
    ),
  );

  getit.registerSingleton<AnotherDayWeatherUseCase>(
    AnotherDayWeatherUseCase(
      weatherRepo: getit.get<WeatherRepo>(),
    ),
  );

  getit.registerSingleton<GetMyLocationUseCase>(
    GetMyLocationUseCase(
      locationRepo: getit.get<LocationRepo>(),
    ),
  );

  getit.registerSingleton<SearchForLocationsUseCase>(
    SearchForLocationsUseCase(
      locationRepo: getit.get<LocationRepo>(),
    ),
  );
}
