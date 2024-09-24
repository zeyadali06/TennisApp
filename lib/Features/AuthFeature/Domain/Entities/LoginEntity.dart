import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class LoginEntity {
  String? email;

  LoginEntity({this.email});

  Map<String, dynamic> toMap() {
    return {
      ConstantNames.email: email,
    };
  }
}
