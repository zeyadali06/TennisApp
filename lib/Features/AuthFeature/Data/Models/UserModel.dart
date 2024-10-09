import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class UserModel {
  String? fullName;
  String? email;
  String? uid;

  UserModel({this.fullName, this.email, this.uid});

  Map<String, dynamic> toMap() {
    return {
      ConstantNames.fullNameField: fullName,
      ConstantNames.emailField: email,
      ConstantNames.uidField: uid,
    };
  }
}
