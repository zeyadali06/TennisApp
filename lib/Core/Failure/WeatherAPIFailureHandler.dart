import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class WeatherAPIFailureHandler extends RequestFailed {
  late String message;

  WeatherAPIFailureHandler(dynamic e) : super(null) {
    message = e.message;
  }
}
