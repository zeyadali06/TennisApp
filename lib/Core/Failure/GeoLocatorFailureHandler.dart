import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class GeolocatorFailureHandler extends RequestFailed {
  late String message;

  GeolocatorFailureHandler(int code) : super(null) {
    if (code == 0) {
      message = 'Error try again later';
    } else if (code == 1) {
      message = 'Location Permission Denied!';
    }
  }
}
