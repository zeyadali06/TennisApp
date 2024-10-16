import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';

abstract class AuthRepo {
  Future<RequestResault<UserModel, FirebaseFailureHandler>> signUp(RegisterEntity registerData, String password);
  Future<RequestResault<UserModel, FirebaseFailureHandler>> login(LoginEntity loginData, String password);
  Future<RequestResault<UserModel, FirebaseFailureHandler>> forgetPassword(String email);
}
