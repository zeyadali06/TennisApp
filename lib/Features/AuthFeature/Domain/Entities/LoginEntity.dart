import 'package:tennis_app/Core/Utils/Constants.dart';

class LoginEntity {
  String? email;

  LoginEntity({this.email});

  Map<String, dynamic> toMap() {
    return {
      ConstantNames.emailField: email,
    };
  }
}
