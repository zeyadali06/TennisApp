import 'package:weather_app/Core/Utils/ConstantsNames.dart';

class RegisterEntity {
  String? fullName;
  String? email;

  RegisterEntity({this.fullName, this.email});

  Map<String, dynamic> toMap() {
    return {
      ConstantNames.fullName: fullName,
      ConstantNames.email: email,
    };
  }
}
