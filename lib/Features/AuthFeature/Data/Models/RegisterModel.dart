class RegisterModel {
  String? fullName;
  String? email;

  RegisterModel({this.fullName, this.email});

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "email": email,
    };
  }
}
