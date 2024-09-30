import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/PlacesServices.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';

GetIt getit = GetIt.instance;

void setup() {
  getit.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(),
  );

  getit.registerSingleton<Dio>(
    Dio(),
  );

  getit.registerSingleton<PlacesServices>(
    PlacesServices(
      dio: getit.get<Dio>(),
    ),
  );

  getit.registerSingleton<ForgetPasswordUseCase>(
    ForgetPasswordUseCase(
      authRepo: getit.get<AuthRepoImpl>(),
    ),
  );
}
