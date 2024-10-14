import 'package:tennis_app/Core/Failure/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class AIModelFailureHandler extends RequestFailed {
  late String message;
  AIModelFailureHandler(Object e) : super(null) {
    if (e is int) {
      if (e == 0) {
        message = 'Choose location first';
      } else {
        message = 'Error try again later';
      }
    } else if (e is NoInternetException) {
      message = e.message;
    } else {
      message = 'Error try again later';
    }
  }
}
