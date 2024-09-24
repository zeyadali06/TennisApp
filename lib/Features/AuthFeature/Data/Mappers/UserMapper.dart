import 'package:tennis_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';

class UserMapper {
  static LoginEntity toLoginEntity(UserModel userModel) {
    return LoginEntity(email: userModel.email);
  }

  static RegisterEntity toRegisterEntity(UserModel userModel) {
    return RegisterEntity(email: userModel.email, fullName: userModel.fullName);
  }
}
