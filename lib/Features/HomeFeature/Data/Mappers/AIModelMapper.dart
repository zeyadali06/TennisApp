import 'package:tennis_app/Features/HomeFeature/Domain/Entities/AIModelEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/ForecastWeatherModel.dart';

class AIModelMapper {
  static AIModelEntity fromCurrentWeatherModel(CurrentWeatherModel currentWeatherModel) {
    return AIModelEntity(
      humidity: currentWeatherModel.humidity,
      feelslikeC: currentWeatherModel.feelslikeC,
      conditionText: currentWeatherModel.condition.text,
    );
  }

  static AIModelEntity fromForecastWeatherModel(ForecastWeatherModel forecastWeatherModel) {
    return AIModelEntity(
      humidity: forecastWeatherModel.hour[0].humidity,
      feelslikeC: forecastWeatherModel.hour[0].feelslikeC,
      conditionText: forecastWeatherModel.hour[0].condition.text,
    );
  }
}
