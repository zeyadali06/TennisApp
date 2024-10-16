import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class FirebaseFailureHandler extends RequestFailed {
  late String message;

  FirebaseFailureHandler(dynamic e) : super(null) {
    message = e.message;
  }
}
