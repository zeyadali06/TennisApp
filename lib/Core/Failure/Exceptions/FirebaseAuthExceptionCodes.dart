import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';

class FirebaseAuthExceptionCodes extends RequestFailed {
  late String message;
  FirebaseAuthExceptionCodes(FirebaseAuthException e) : super(null) {
    if (e.code == 'weak-password') {
      message = 'Password should be at least 6 characters';
    } else if (e.code == 'email-already-in-use') {
      message = 'Email already exist';
    } else if (e.code == 'username-already-in-use') {
      message = 'Username already exist';
    } else if (e.code == 'wrong-confirmation') {
      message = "Password and it's confirmation dosen't same";
    } else if (e.code == 'invalid-email') {
      message = 'Invalid Email';
    } else if (e.code == 'network-request-failed') {
      message = 'No Internet Connection';
    } else if (e.code == 'user-not-found') {
      message = 'Email not found';
    } else if (e.code == 'username-not-found') {
      message = 'Username not found';
    } else if (e.code == 'too-many-requests') {
      message = 'Too many attempts, Try again later';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password';
    } else if (e.code == 'invalid-credential') {
      message = 'Error, Please enter correct data';
    } else if (e.code == "requires-recent-login") {
      message = 'Make this operation after recent login';
    } else if (e.code == 'invalid-verification-code') {
      message = 'Code is incorrect';
    } else if (e.code == 'too-many-requests') {
      message = 'Many attempts, try again later';
    } else {
      TryAgainException error = TryAgainException();
      message = error.message;
    }
  }
}
