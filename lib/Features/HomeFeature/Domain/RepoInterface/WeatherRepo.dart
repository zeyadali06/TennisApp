import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';

abstract class WeatherRepo {
  Future<RequestResult<WeatherModel, WeatherAPIFailureHandler>>
      getForecastWeather(DateTime dateTime);
}
