import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/Core/Failure/FirebaseFailure.dart';
import 'package:weather_app/Features/AuthFeature/Data/Models/LoginModel.dart';
import 'package:weather_app/Features/AuthFeature/Data/Models/RegisterModel.dart';

abstract class AuthRepo {
  Future<FirebaseResult<UserCredential>> register(RegisterModel registerData, String password);
  Future<FirebaseResult<UserCredential>> login(LoginModel loginData, String password);
}
