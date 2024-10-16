import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/ForecastWeatherModel.dart';

abstract class WeatherRepo {
  Future<RequestResault<CurrentWeatherModel, WeatherAPIFailureHandler>> getCurrentWeather();
  Future<RequestResault<ForecastWeatherModel, WeatherAPIFailureHandler>> getForecastWeather(DateTime dateTime);
}
