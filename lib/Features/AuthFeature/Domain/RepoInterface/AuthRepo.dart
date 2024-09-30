import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';

abstract class AuthRepo {
  Future<RequestResault> register(RegisterEntity registerData, String password);
  Future<RequestResault> login(LoginEntity loginData, String password);
  Future<RequestResault> forgetPassword(String email);
}
