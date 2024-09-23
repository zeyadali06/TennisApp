class RegisterEntity {
  String? fullName;
  String? email;

  RegisterEntity({this.fullName, this.email});

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "email": email,
    };
  }
}
