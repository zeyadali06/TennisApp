import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:tennis_app/Core/Failure/Exceptions/FirebaseAuthExceptionCodes.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';
import 'package:tennis_app/Core/Utils/Authentication.dart';

class ForgetPasswordUseCase {
  ForgetPasswordUseCase({required this.authRepo, required this.accountData});

  final AuthRepo authRepo;
  final AccountData accountData;

  Future<RequestResult<UserModel, FirebaseFailureHandler>> forgetPassword(
      String email) async {
    try {
      await accountData.getUIDFromFirestore(email);
      RequestResult res = await authRepo.forgetPassword(email);

      if (res is RequestSuccess) {
        return RequestResult.success(res.data);
      } else if (res is RequestFailed) {
        return RequestResult.failure(res.data);
      } else {
        return RequestResult.failure(
            FirebaseFailureHandler(TryAgainException()));
      }
    } on RangeError catch (_) {
      return RequestResult.failure(
        FirebaseFailureHandler(
          FirebaseAuthExceptionCodes(
            FirebaseAuthException(code: "user-not-found"),
          ),
        ),
      );
    } on FirebaseFailureHandler catch (e) {
      return RequestResult.failure(e);
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }
}
