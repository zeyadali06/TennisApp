import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tennis_app/Core/Models/AutoLoginModel.dart';
import 'package:tennis_app/Core/Utils/Constants.dart';

class LocalDatabaseService {
  LocalDatabaseService({required this.flutterSecureStorage});

  final FlutterSecureStorage flutterSecureStorage;

  Future<void> writeLoginData(
      String email, String password, String fullName) async {
    await flutterSecureStorage.write(
        key: ConstantNames.localEmail, value: email);
    await flutterSecureStorage.write(
        key: ConstantNames.localPassword, value: password);
    await flutterSecureStorage.write(
        key: ConstantNames.localFullName, value: fullName);
  }

  Future<AutoLoginModel> readLoginData() async {
    AutoLoginModel model = AutoLoginModel(
      fullName:
          await flutterSecureStorage.read(key: ConstantNames.localFullName) ??
              "",
      email:
          await flutterSecureStorage.read(key: ConstantNames.localEmail) ?? "",
      password:
          (await flutterSecureStorage.read(key: ConstantNames.localPassword)) ??
              "",
    );
    return model;
  }
}
