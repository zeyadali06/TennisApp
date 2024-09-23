class UserModel {
  String? fullName;
  String? email;
  String? uid;

  UserModel({this.fullName, this.email, this.uid});

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "email": email,
      "uid": uid,
    };
  }
}
