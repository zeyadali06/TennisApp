import 'package:tennis_app/Core/Utils/Constants.dart';

class UserModel {
  String? fullName;
  String? email;
  String? uid;

  UserModel({this.fullName, this.email, this.uid});

  Map<String, dynamic> toMap() {
    return {
      Constants.fullNameField: fullName,
      Constants.emailField: email,
      Constants.uidField: uid,
    };
  }
}
