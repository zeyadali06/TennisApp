import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Models/AutoLoginModel.dart';
import 'package:tennis_app/Core/Utils/Constants.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Core/Utils/LocalDatabaseService.dart';
import 'package:tennis_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:tennis_app/Core/Failure/Exceptions/NoInternetException.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';
import 'package:tennis_app/Core/Failure/Exceptions/FirebaseAuthExceptionCodes.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';
import 'package:tennis_app/Core/Utils/Authentication.dart';
import 'package:tennis_app/Core/Utils/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({
    required this.firestore,
    required this.signIn,
    required this.signOut,
    required this.register,
    required this.accountData,
    required this.locationManagerRepo,
    required this.localDatabaseService,
  });

  final SignIn signIn;
  final SignOut signOut;
  final Register register;
  final Firestore firestore;
  final AccountData accountData;
  final LocationManagerRepo locationManagerRepo;
  final LocalDatabaseService localDatabaseService;

  @override
  Future<RequestResult<UserModel, FirebaseFailureHandler>> login(
    LoginEntity loginData,
    String password,
  ) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
          FirebaseFailureHandler(NoInternetException()),
        );
      }

      UserCredential user = await signIn.signIn(loginData.email!, password);
      String fullName = await firestore.getField(
        collectionPath: Constants.usersDataCollection,
        docName: user.user!.uid,
        key: Constants.fullNameField,
      );

      UserModel userModel = UserModel(
        email: loginData.email,
        uid: user.user!.uid,
        fullName: fullName,
      );
      Constants.userModel = userModel;

      await locationManagerRepo.getLocations();

      return RequestResult.success(userModel);
    } on FirebaseAuthException catch (e) {
      return RequestResult.failure(
        FirebaseFailureHandler(FirebaseAuthExceptionCodes(e)),
      );
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<UserModel, FirebaseFailureHandler>> signUp(
    RegisterEntity registerData,
    String password,
  ) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
          FirebaseFailureHandler(NoInternetException()),
        );
      }

      UserCredential user =
          await register.register(registerData.toMap(), password);
      UserModel userModel = UserModel(
        email: registerData.email,
        uid: user.user!.uid,
        fullName: registerData.fullName,
      );

      Constants.userModel = userModel;
      await firestore.setField(
        collectionPath: Constants.locationsCollection,
        docName: user.user!.uid,
        data: {Constants.locationsField: []},
      );

      await localDatabaseService.writeLoginData(
        registerData.email!,
        password,
        registerData.fullName!,
      );

      return RequestResult.success(userModel);
    } on FirebaseAuthException catch (e) {
      return RequestResult.failure(
        FirebaseFailureHandler(FirebaseAuthExceptionCodes(e)),
      );
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<UserModel, FirebaseFailureHandler>> forgetPassword(
    String email,
  ) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
          FirebaseFailureHandler(NoInternetException()),
        );
      }

      await accountData.resetPassword(email);

      return RequestResult.success(UserModel());
    } on FirebaseAuthException catch (e) {
      return RequestResult.failure(
        FirebaseFailureHandler(FirebaseAuthExceptionCodes(e)),
      );
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<UserModel, FirebaseFailureHandler>> autoLogin() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
          FirebaseFailureHandler(NoInternetException()),
        );
      }

      AutoLoginModel model = await localDatabaseService.readLoginData();

      UserCredential user = await signIn.signIn(model.email, model.password);

      UserModel userModel = UserModel(
        email: model.email,
        uid: user.user!.uid,
        fullName: model.fullName,
      );
      Constants.userModel = userModel;

      await locationManagerRepo.getLocations();

      return RequestResult.success(userModel);
    } on FirebaseAuthException catch (e) {
      return RequestResult.failure(
        FirebaseFailureHandler(FirebaseAuthExceptionCodes(e)),
      );
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<void, FirebaseFailureHandler>> logout() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
          FirebaseFailureHandler(NoInternetException()),
        );
      }

      await localDatabaseService.writeLoginData(null, null, null);

      await signOut.signOut();

      Constants.userModel = UserModel();
      locationManagerRepo.locations.clear();

      await locationManagerRepo.getLocations();

      return RequestResult.success(null);
    } on FirebaseAuthException catch (e) {
      return RequestResult.failure(
        FirebaseFailureHandler(FirebaseAuthExceptionCodes(e)),
      );
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }
}
