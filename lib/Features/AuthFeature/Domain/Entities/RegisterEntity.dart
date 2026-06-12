import 'package:tennis_app/Core/Utils/Constants.dart';

class RegisterEntity {
  String? fullName;
  String? email;

  RegisterEntity({this.fullName, this.email});

  Map<String, dynamic> toMap() {
    return {
      Constants.fullNameField: fullName,
      Constants.emailField: email,
    };
  }
}
