class LoginEntity {
  String? email;

  LoginEntity({this.email});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
    };
  }
}
