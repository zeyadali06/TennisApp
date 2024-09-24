import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class UserModel {
  String? fullName;
  String? email;
  String? uid;

  UserModel({this.fullName, this.email, this.uid});

  Map<String, dynamic> toMap() {
    return {
      ConstantNames.fullName: fullName,
      ConstantNames.email: email,
      ConstantNames.uid: uid,
    };
  }
}
