import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/Authentication.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/WeatherApiServices.dart';
import 'package:tennis_app/Features/HomeFeature/Data/RepoImplementation/HomeRepoImpl.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/LocationServices.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationRepoImpl.dart';
import 'package:tennis_app/Features/LocationFeature/Data/RepoImplementation/LocationManagerRepoImpl.dart';

GetIt getit = GetIt.instance;

void setup() {
  getit.registerSingleton<Dio>(
    Dio(),
  );

  getit.registerSingleton<SignIn>(
    SignIn(),
  );

  getit.registerSingleton<Register>(
    Register(),
  );

  getit.registerSingleton<AccountData>(
    AccountData(),
  );

  getit.registerSingleton<Firestore>(
    Firestore(),
  );

  getit.registerSingleton<WeatherApiServices>(
    WeatherApiServices(
      dio: getit.get<Dio>(),
    ),
  );

  getit.registerSingleton<LocationServices>(
    LocationServices(
      dio: getit.get<Dio>(),
    ),
  );

  getit.registerSingleton<LocationManagerRepoImpl>(
    LocationManagerRepoImpl(
      firestore: getit.get<Firestore>(),
    ),
  );

  getit.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      weatherApiServices: getit.get<WeatherApiServices>(),
      locationManagerRepo: getit.get<LocationManagerRepoImpl>(),
    ),
  );

  getit.registerSingleton<LocationRepoImpl>(
    LocationRepoImpl(
      locationServices: getit.get<LocationServices>(),
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
}
