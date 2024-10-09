import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Failure/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/Authentication.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.firestore, required this.signIn, required this.register, required this.accountData, required this.locationManagerRepo});

  final Firestore firestore;
  final SignIn signIn;
  final Register register;
  final AccountData accountData;
  final LocationManagerRepo locationManagerRepo;

  @override
  Future<RequestResault<UserModel, FirebaseFailureHandler>> login(LoginEntity loginData, String password) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(FirebaseFailureHandler(NoInternetException()));
      }

      UserCredential user = await signIn.signIn(loginData.email!, password);
      String fullName = await firestore.getField(collectionPath: ConstantNames.usersDataCollection, docName: user.user!.uid, key: ConstantNames.fullNameField);
      UserModel userModel = UserModel(email: loginData.email, uid: user.user!.uid, fullName: fullName);
      ConstantNames.userModel = userModel;
      await locationManagerRepo.getLocations();
      return RequestResault.success(userModel);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<UserModel, FirebaseFailureHandler?>> signUp(RegisterEntity registerData, String password) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(FirebaseFailureHandler(NoInternetException()));
      }

      UserCredential user = await register.register(registerData.toMap(), password);
      UserModel userModel = UserModel(email: registerData.email, uid: user.user!.uid, fullName: registerData.fullName);
      ConstantNames.userModel = userModel;
      await firestore.setField(collectionPath: ConstantNames.locationsCollection, docName: user.user!.uid, data: {ConstantNames.locationsField: []});
      return RequestResault.success(userModel);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<UserModel, FirebaseFailureHandler>> forgetPassword(String email) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(FirebaseFailureHandler(NoInternetException()));
      }

      await accountData.resetPassword(email);
      return RequestResault.success(UserModel());
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }
}
