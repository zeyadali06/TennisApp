import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/Core/Failure/FirebaseFailure.dart';
import 'package:weather_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:weather_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';

abstract class AuthRepo {
  Future<FirebaseResult<UserCredential>> register(RegisterEntity registerData, String password);
  Future<FirebaseResult<UserCredential>> login(LoginEntity loginData, String password);
}
