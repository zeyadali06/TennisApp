import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailure.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/Registration.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';

class ForgetPasswordUseCase {
  AuthRepo authRepo;
  ForgetPasswordUseCase({required this.authRepo});

  Future<FirebaseResult> forgetPassword(String email) async {
    try {
      await AccountData.getUIDFromFirestore(email);
      return await authRepo.forgetPassword(email);
    } on RangeError catch (_) {
      throw FirebaseAuthException(code: "user-not-found");
    } catch (e) {
      return FirebaseResult.failure(e);
    }
  }
}
