import 'package:get_it/get_it.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';

GetIt getit = GetIt.instance;

void setup() {
  getit.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(),
  );
}