import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';

class WeatherAPIFailureHandlerCodes extends RequestFailed {
  late String message;
  WeatherAPIFailureHandlerCodes(int code) : super(null) {
    if (code == 1003) {
      message = 'Search for anything';
    } else if (code == 1006) {
      message = 'Please, enter valid location';
    } else {
      TryAgainException error = TryAgainException();
      message = error.message;
    }
  }
}
