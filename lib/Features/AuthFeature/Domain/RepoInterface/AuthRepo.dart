import 'package:weather_app/Core/Failure/FirebaseFailure.dart';
import 'package:weather_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:weather_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';

abstract class AuthRepo {
  Future<FirebaseResult> register(RegisterEntity registerData, String password);
  Future<FirebaseResult> login(LoginEntity loginData, String password);
}