import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/Registration.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';

class ForgetPasswordUseCase {
  AuthRepo authRepo;
  ForgetPasswordUseCase({required this.authRepo});

  Future<RequestResault> forgetPassword(String email) async {
    try {
      await AccountData.getUIDFromFirestore(email);
      return await authRepo.forgetPassword(email);
    } on RangeError catch (_) {
      throw FirebaseAuthException(code: "user-not-found");
    } catch (e) {
      return RequestResault.failure(e);
    }
  }
}
