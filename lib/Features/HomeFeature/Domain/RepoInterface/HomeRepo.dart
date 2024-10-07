import 'package:tennis_app/Core/Failure/RequestFailure.dart';

abstract class HomeRepo {
  Future<RequestResault> getCurrentWeather();
  Future<RequestResault> getForecastWeather(DateTime date);
}
