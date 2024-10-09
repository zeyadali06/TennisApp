import 'package:tennis_app/Core/Failure/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class WeatherAPIFailureHandler extends RequestFailed {
  late String message;
  WeatherAPIFailureHandler(Object e) : super(null) {
    if (e is int) {
      if (e == 1003) {
        message = 'Search for anything';
      } else if (e == 1006) {
        message = 'Please, enter valid location';
      } else if (e == 0) {
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
