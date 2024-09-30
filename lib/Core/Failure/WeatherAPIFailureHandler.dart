import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class WeatherAPIFailureHandler extends RequestFailed {
  late String message;
  WeatherAPIFailureHandler(int errorCode) : super(null) {
    if (errorCode == 1003) {
      message = 'Search for anything';
    } else if (errorCode == 1006) {
      message = 'Please, enter valid location';
    } else {
      message = 'Error try again later';
    }
  }
}
