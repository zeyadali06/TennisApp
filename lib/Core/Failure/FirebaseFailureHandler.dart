import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/Core/Failure/FirebaseFailure.dart';

class FirebaseFailureHandler extends FirebaseFailure {
  late String message;
  FirebaseFailureHandler(Object e) : super(null) {
    if (e is FirebaseAuthException) {
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
      } else if (e.code == 'unknown-error') {
        message = 'Error try again';
      } else {
        message = 'Error try again later';
      }
    } else {
      message = 'Error try again later';
    }
  }
}
