import 'package:tennis_app/Core/Failure/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class GeolocatorFailureHandler extends RequestFailed {
  late String message;

  GeolocatorFailureHandler(Object e) : super(null) {
    if (e is int) {
      if (e == 0) {
        message = 'Error try again later';
      } else if (e == 1) {
        message = 'Location Permission Denied!';
      }
    } else if (e is NoInternetException) {
      message = e.message;
    }
  }
}
