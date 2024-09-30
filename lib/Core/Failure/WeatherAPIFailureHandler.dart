import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class WeatherAPIFailureHandler extends RequestFailed {
  late String message;
  WeatherAPIFailureHandler(Object e) : super(null) {
    if (e is int) {
      if (e == 1003) {
        message = 'Search for anything';
      } else if (e == 1006) {
        message = 'Please, enter valid location';
      }
    } else {
      message = 'Error try again later';
    }
  }
}