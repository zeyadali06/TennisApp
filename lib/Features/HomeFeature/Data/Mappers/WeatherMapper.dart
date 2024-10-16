import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/ForecastWeatherModel.dart';

class WeatherMapper {
  static WeatherEntity fromCurrentWeatherModel(CurrentWeatherModel currentWeatherModel) {
    return WeatherEntity(
      tempC: currentWeatherModel.tempC,
      windKph: currentWeatherModel.windKph,
      humidity: currentWeatherModel.humidity,
      uv: currentWeatherModel.uv,
      feelslikeC: currentWeatherModel.feelslikeC,
      visKm: currentWeatherModel.visKm,
      pressureMb: currentWeatherModel.pressureMb,
      lastUpdated: currentWeatherModel.lastUpdated,
      icon: currentWeatherModel.condition.icon,
    );
  }

  static WeatherEntity fromForecastWeatherModel(ForecastWeatherModel forecastWeatherModel) {
    return WeatherEntity(
      tempC: forecastWeatherModel.hour[0].tempC,
      windKph: forecastWeatherModel.hour[0].windKph,
      humidity: forecastWeatherModel.hour[0].humidity,
      uv: forecastWeatherModel.hour[0].uv,
      feelslikeC: forecastWeatherModel.hour[0].feelslikeC,
      visKm: forecastWeatherModel.hour[0].visKm,
      pressureMb: forecastWeatherModel.hour[0].pressureMb,
      lastUpdated: forecastWeatherModel.date,
      icon: forecastWeatherModel.hour[0].condition.icon,
    );
  }
}
