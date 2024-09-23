class LoginModel {
  String? email;

  LoginModel({this.email});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
    };
  }
}
